# CertA Helm Chart

A Helm chart for deploying CertA (Simple Certificate Authority) - a Certificate Authority for local use.

## Introduction

CertA is a Simple Certificate Authority built with ASP.NET Core and PostgreSQL. It provides:
- **Certificate Authority** for generating and managing X.509 certificates
- **Web Management Interface** for certificate creation and management
- **PostgreSQL database** for storing certificates and CA data
- **User authentication** with ASP.NET Core Identity
- **Wildcard certificate support** with proper validation

## Installation

### From Helm Repository

```bash
# Add the repository
helm repo add swipentap https://swipentap.github.io/charts
helm repo update

# Install with default values
helm install my-certa swipentap/certa

# Install with custom values
helm install my-certa swipentap/certa -f custom-values.yaml
```

### From Local Chart

```bash
# Install with default values
helm install my-certa ./swipentap/certa

# Install with custom values
helm install my-certa ./swipentap/certa -f custom-values.yaml
```

## Configuration

Key configuration options in `values.yaml`:

### PostgreSQL

- `postgresql.image.repository` - Docker image repository (default: `postgres`)
- `postgresql.image.tag` - Docker image tag (default: `15`)
- `postgresql.env.POSTGRES_DB` - Database name (default: `certa`)
- `postgresql.env.POSTGRES_USER` - Database user (default: `certa`)
- `postgresql.env.POSTGRES_PASSWORD` - Database password (default: `certa123`)
- `postgresql.persistence.enabled` - Enable persistent storage (default: `true`)
- `postgresql.persistence.size` - PVC size (default: `10Gi`)

### CertA Application

- `certa.image.repository` - Docker image repository (default: `judyandiealvarez/certa`)
- `certa.image.tag` - Docker image tag (default: `1.0.0`)
- `certa.service.type` - Service type (default: `NodePort`)
- `certa.service.port` - Application port (default: `8080`)
- `certa.service.nodePort` - NodePort number (default: `30080`)
- `certa.resources` - CPU and memory requests/limits
- `certa.env.ASPNETCORE_ENVIRONMENT` - Environment (default: `Production`)
- `certa.env.ASPNETCORE_DATA_PROTECTION__DEFAULT_KEY_LIFETIME` - Key lifetime in days (default: `90`)

## Access

After installation:

- **Web Interface**: 
  - NodePort: `http://<node-ip>:30080`
  - ClusterIP: `http://{{ release-name }}-certa.certa.svc.cluster.local:8080`
  - Create an account on first access to start using CertA

## Upgrading

```bash
# If installed from repository
helm repo update
helm upgrade my-certa swipentap/certa

# If installed from local chart
helm upgrade my-certa ./swipentap/certa
```

## Uninstallation

```bash
helm uninstall my-certa
```

Note: PVC is not deleted by default. To delete it manually:
```bash
kubectl delete pvc <release-name>-certa-postgresql-data -n certa
```

## Architecture

The chart deploys two main components:

1. **PostgreSQL**: Database for certificates, CA data, and user information
2. **CertA Application**: ASP.NET Core application providing the CA and web interface on port 8080

## Requirements

- Kubernetes 1.23+
- Helm 3.8.0+
- Persistent storage for PostgreSQL (if persistence is enabled)

## Notes

- For production use, change default PostgreSQL credentials
- The NodePort service type can be changed to LoadBalancer or ClusterIP depending on your infrastructure
- CertA requires database migrations to be applied on first startup
- The root CA certificate can be downloaded from the web interface for trust establishment
