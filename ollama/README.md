# Ollama Helm Chart

A Helm chart for deploying Ollama LLM server on Kubernetes.

## Installation

### From Helm Repository

```bash
# Add the repository
helm repo add swipentap https://swipentap.github.io/charts
helm repo update

# Install with default values
helm install my-release swipentap/ollama

# Install with custom values
helm install my-release swipentap/ollama -f custom-values.yaml

# Install to use existing PVC (if you already have ollama-data PVC)
helm install my-release swipentap/ollama --set ollama.persistence.existingClaim=ollama-data
```

### From Local Chart

```bash
# Install with default values
helm install my-release ./swipentap/ollama

# Install with custom values
helm install my-release ./swipentap/ollama -f custom-values.yaml
```

## Configuration

Key configuration options in `values.yaml`:

- `ollama.image.repository` - Docker image repository (default: `ollama/ollama`)
- `ollama.image.tag` - Docker image tag (default: `latest`)
- `ollama.service.type` - Service type (default: `NodePort`)
- `ollama.service.nodePort` - NodePort number (default: `31134`)
- `ollama.resources` - CPU and memory requests/limits
- `ollama.models` - List of models to auto-pull on startup
- `ollama.persistence.enabled` - Enable persistent storage (default: `true`)
- `ollama.persistence.size` - PVC size (default: `20Gi`)
- `ollama.persistence.existingClaim` - Use existing PVC (set to PVC name)
- `webui.enabled` - Enable WebUI (default: `true`)
- `webui.service.nodePort` - WebUI NodePort number (default: `31135`)
- `webui.env.OLLAMA_BASE_URL` - Ollama service URL (auto-configured if empty)
- `webui.resources` - WebUI CPU and memory requests/limits

## Access

After installation, access:
- **Ollama API**: 
  - NodePort: `http://<node-ip>:31134`
  - ClusterIP: `http://<release-name>-ollama.ollama.svc.cluster.local:11434`
- **WebUI** (if enabled):
  - NodePort: `http://<node-ip>:31135`
  - ClusterIP: `http://<release-name>-ollama-webui.ollama.svc.cluster.local:8080`

## Upgrading

```bash
# If installed from repository
helm repo update
helm upgrade my-release swipentap/ollama

# If installed from local chart
helm upgrade my-release ./swipentap/ollama
```

## Uninstallation

```bash
helm uninstall my-release
```

Note: PVC is not deleted by default. To delete it manually:
```bash
kubectl delete pvc <release-name>-ollama-data -n ollama
```
