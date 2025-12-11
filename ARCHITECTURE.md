# Multi-Container App Architecture

## Overview

This module creates a shared Container App Environment and deploys multiple container apps within it.

## Architecture Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                     Resource Group                              │
│  ┌───────────────────────────────────────────────────────────┐ │
│  │         Container App Environment                         │ │
│  │  - Shared Log Analytics Workspace                         │ │
│  │  - Optional VNet Integration                              │ │
│  │  - Consumption Workload Profile                           │ │
│  │                                                             │ │
│  │  ┌────────────────┐  ┌────────────────┐  ┌──────────────┐│ │
│  │  │ Container App  │  │ Container App  │  │ Container    ││ │
│  │  │   "frontend"   │  │   "backend"    │  │  App "worker"││ │
│  │  │                │  │                │  │              ││ │
│  │  │ ┌────────────┐ │  │ ┌────────────┐ │  │ ┌──────────┐││ │
│  │  │ │  nginx     │ │  │ │    api     │ │  │ │processor │││ │
│  │  │ │ container  │ │  │ │ container  │ │  │ │container │││ │
│  │  │ └────────────┘ │  │ └────────────┘ │  │ └──────────┘││ │
│  │  │                │  │                │  │              ││ │
│  │  │ Ingress:       │  │ Ingress:       │  │ No Ingress   ││ │
│  │  │ - External ✓   │  │ - Internal     │  │              ││ │
│  │  │ - Port 80      │  │ - Port 8080    │  │              ││ │
│  │  │                │  │                │  │              ││ │
│  │  │ Scaling:       │  │ Scaling:       │  │ Scaling:     ││ │
│  │  │ - Min: 1       │  │ - Min: 2       │  │ - Min: 0     ││ │
│  │  │ - Max: 5       │  │ - Max: 10      │  │ - Max: 2     ││ │
│  │  └────────────────┘  └────────────────┘  └──────────────┘│ │
│  │                                                             │ │
│  └───────────────────────────────────────────────────────────┘ │
│                                                                 │
│  ┌───────────────────────────────────────────────────────────┐ │
│  │         User Assigned Identity (Shared)                   │ │
│  │  - For ACR authentication                                 │ │
│  │  - Shared across all apps in environment                  │ │
│  └───────────────────────────────────────────────────────────┘ │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘

External Traffic → Frontend App (Public FQDN)
                     ↓
                  Backend App (Internal FQDN)
                     ↓
                  Worker App (No Network Access)
```

## Component Breakdown

### Shared Components (Per Module)
- **Container App Environment**: Single environment shared by all apps
- **User Assigned Identity**: Shared identity for ACR access
- **Log Analytics Workspace**: Centralized logging
- **Resource Group**: Contains all resources
- **VNet/Subnet**: Optional, shared if enabled

### Per-App Components
Each container app has its own:
- **Container App Resource**: Isolated compute
- **Containers**: One or more containers per app
- **Scaling Configuration**: Independent min/max replicas
- **Ingress Settings**: Optional, can be external/internal
- **Environment Variables**: Per-container configuration
- **Secrets**: From Key Vault, scoped to app
- **Registry Configuration**: Optional ACR credentials

## Resource Naming

```
Format: {product}-{component}-{app_key}-{env}

Examples:
- Container App Environment: myproduct-services-dev-env
- Frontend App:             myproduct-services-frontend-dev
- Backend App:              myproduct-services-backend-dev
- Worker App:               myproduct-services-worker-dev
```

## Network Flow

### External Traffic
```
Internet → Azure Front Door/App Gateway (optional)
         → Frontend Container App (External Ingress)
         → Backend Container App (Internal Ingress)
```

### Internal Traffic
```
Frontend App → Backend App (via internal FQDN)
             → http://myproduct-services-backend-dev.internal

Backend App → External Services (DB, Storage, etc.)
Worker App  → External Services (DB, Storage, etc.)
```

### No Network Access
```
Worker App (ingress_enabled = false)
- Cannot receive HTTP traffic
- Can make outbound calls
- Good for batch processing, scheduled tasks
```

## Scaling Strategy

Each app scales independently:

```
Frontend App:  
  ├─ Min: 2 replicas (always available)
  └─ Max: 10 replicas (handle traffic spikes)

Backend API:   
  ├─ Min: 3 replicas (higher availability)
  └─ Max: 20 replicas (CPU/memory intensive)

Worker:        
  ├─ Min: 0 replicas (cost optimization)
  └─ Max: 5 replicas (scale on demand)
```

## Cost Optimization

### Shared Resources Save Money
- **1 Container App Environment** instead of 3
- **1 Log Analytics Workspace** instead of 3
- **1 User Assigned Identity** instead of 3
- **Shared VNet/Subnet** (if used)

### Independent Scaling
- Frontend can scale to 0 during low traffic
- Backend maintains minimum replicas for availability
- Worker only runs when needed (min 0)

## Security Model

### Identity & Access
```
Container App Identity (System/User Assigned)
    ├─ Pull images from ACR
    ├─ Access Key Vault secrets
    └─ Connect to Azure services (Storage, DB, etc.)
```

### Network Security
```
External Apps:  Internet → Azure → App (HTTPS enforced)
Internal Apps:  Only accessible within VNet
No Ingress:     No network access at all
```

### Secrets Management
```
Key Vault → Module Data Source → Container App Secrets
         → Referenced as environment variables
         → Never in plain text in config
```

## High Availability

### Zone Redundancy (Optional)
- Apps distributed across availability zones
- Automatic failover
- Higher availability SLA

### Revision Management
- Single mode: Only latest revision active
- Multiple mode: Traffic split across revisions (blue/green)

## Monitoring & Observability

### Shared Log Analytics
```
All Apps → Container App Environment → Log Analytics
        → Logs available in:
           - Azure Portal
           - Log Analytics queries
           - Application Insights (if configured)
```

### Metrics Per App
- CPU usage
- Memory usage
- Request count
- Response time
- Replica count

## Use Cases

### Microservices Architecture
```
API Gateway (frontend) → User Service (backend)
                      → Order Service (backend)
                      → Payment Service (backend)
                      → Notification Worker (no ingress)
```

### Web Application
```
Web UI (frontend)    → Public facing
REST API (backend)   → Internal only
Background Jobs      → No ingress
```

### Batch Processing
```
API (frontend)       → Receives job requests
Processor (backend)  → Internal job API
Workers (no ingress) → Process jobs from queue
```

## Deployment Patterns

### Single App Deployment
```hcl
module "container_app" {
  container_apps = {
    main = {
      containers = { app = {...} }
      ingress_enabled = true
    }
  }
}

Result: myproduct-component-main-env
```

### Multi-App Deployment
```hcl
module "container_apps" {
  container_apps = {
    frontend = {...}
    backend  = {...}
    worker   = {...}
  }
}

Result: 
- myproduct-component-frontend-env
- myproduct-component-backend-env
- myproduct-component-worker-env
```

## Best Practices

1. **Use Descriptive App Keys**: `frontend`, `backend`, `worker` not `app1`, `app2`
2. **Group Related Services**: Deploy related microservices in same environment
3. **Separate Environments**: Use different modules for dev/staging/prod
4. **Internal by Default**: Use external ingress only when needed
5. **Scale to Zero**: Set `min_replicas = 0` for non-critical workloads
6. **Health Checks**: Configure liveness/readiness probes (future enhancement)
7. **Resource Limits**: Set appropriate CPU/memory per container
8. **Secrets in Key Vault**: Never hardcode secrets in configuration

## Troubleshooting

### App Not Receiving Traffic
- Check ingress is enabled
- Verify target port matches container port
- Check external_enabled setting
- Review NSG rules if using VNet

### App Not Scaling
- Verify min/max replica settings
- Check scaling rules (future enhancement)
- Review metrics in portal

### Container Won't Start
- Verify image exists and is accessible
- Check registry credentials
- Review container logs
- Validate environment variables
