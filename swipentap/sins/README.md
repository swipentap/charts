# SiNS Helm Chart

A Helm chart for deploying SiNS (Simple Name Server) - a complete DNS server solution with web-based management interface.

## Introduction

SiNS is a DNS server built with .NET 8, PostgreSQL, and Vue.js. It provides:
- **Authoritative and recursive DNS server** supporting UDP and TCP
- **Web Management Interface** with Vue.js
- **PostgreSQL database** for DNS records, cache, and configuration
- **JWT-based authentication** with role-based access control

## Installation

### From Helm Repository

```bash
# Add the repository
helm repo add swipentap https://swipentap.github.io/charts
helm repo update

# Install with default values
helm install my-sins swipentap/sins

# Install with custom values
helm install my-sins swipentap/sins -f custom-values.yaml
```

### From Local Chart

```bash
# Install with default values
helm install my-sins ./swipentap/sins

# Install with custom values
helm install my-sins ./swipentap/sins -f custom-values.yaml
```

## Configuration

Key configuration options in `values.yaml`:

### PostgreSQL

- `postgresql.image.repository` - Docker image repository (default: `postgres`)
- `postgresql.image.tag` - Docker image tag (default: `15`)
- `postgresql.env.POSTGRES_DB` - Database name (default: `dns_server`)
- `postgresql.env.POSTGRES_USER` - Database user (default: `postgres`)
- `postgresql.env.POSTGRES_PASSWORD` - Database password (default: `postgres`)
- `postgresql.persistence.enabled` - Enable persistent storage (default: `true`)
- `postgresql.persistence.size` - PVC size (default: `10Gi`)

### SiNS DNS Server

- `sins.image.repository` - Docker image repository (default: `judyandiealvarez/sins`)
- `sins.image.tag` - Docker image tag (default: `latest`)
- `sins.service.type` - Service type (default: `LoadBalancer`)
- `sins.service.port` - DNS port (default: `53`)
- `sins.resources` - CPU and memory requests/limits
- `sins.dns.cacheTimeout` - Cache timeout in minutes (default: `60`)
- `sins.dns.upstreamServers` - Fallback DNS servers (default: `8.8.8.8`, `1.1.1.1`)

### Web UI (Optional, enabled by default)

- `webui.enabled` - Enable WebUI (default: `true`). Set to `false` to disable the web management interface
- `webui.service.type` - Service type (default: `NodePort`)
- `webui.service.nodePort` - NodePort number (default: `30080`)
- `webui.resources` - WebUI CPU and memory requests/limits

To disable the Web UI:
```bash
helm install my-sins swipentap/sins --set webui.enabled=false
```

## Access

After installation:

- **DNS Server**: 
  - LoadBalancer IP/Port: `53` (UDP/TCP)
  - ClusterIP: `{{ release-name }}-sins.sins.svc.cluster.local:53`
  
- **Web Management Interface** (if enabled):
  - NodePort: `http://<node-ip>:30080`
  - ClusterIP: `http://{{ release-name }}-sins-webui.sins.svc.cluster.local:80`
  - Default credentials: `admin` / `admin123`

## Testing DNS

```bash
# Test DNS resolution
dig @<loadbalancer-ip> example.com
nslookup example.com <loadbalancer-ip>

# Test from within cluster
dig @{{ release-name }}-sins.sins.svc.cluster.local example.com
```

## Upgrading

```bash
# If installed from repository
helm repo update
helm upgrade my-sins swipentap/sins

# If installed from local chart
helm upgrade my-sins ./swipentap/sins
```

## Uninstallation

```bash
helm uninstall my-sins
```

Note: PVC is not deleted by default. To delete it manually:
```bash
kubectl delete pvc <release-name>-sins-postgresql-data -n sins
```

## Architecture

The chart deploys three main components:

1. **PostgreSQL**: Database for DNS records and configuration
2. **SiNS DNS Server**: .NET 8 application handling DNS queries on port 53
3. **Web UI**: Vue.js management interface (optional, enabled by default)

## Requirements

- Kubernetes 1.23+
- Helm 3.8.0+
- Persistent storage for PostgreSQL (if persistence is enabled)

## Notes

- The DNS server requires port 53 (UDP/TCP), which may require special permissions or hostNetwork mode in some environments
- For production use, change default PostgreSQL credentials
- The LoadBalancer service type for DNS may need to be changed to NodePort or ClusterIP depending on your infrastructure
