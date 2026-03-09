# All image and chart registries used by umbrella and related charts

Generated from scanning the umbrella chart and all charts it deploys (including external Helm charts). Includes both **container image registries** and **OCI / chart registries** where relevant.

---

## Container image registries

Registries from which **container images** are pulled when the umbrella and its apps are deployed.

| Registry | Where it's used |
|----------|------------------|
| **docker.io** (default for unqualified names; also **index.docker.io**, **registry-1.docker.io**) | enva-umbrella templates (busybox, alpine, postgres:15-alpine), certa, sins, keycloak-operator, postgresql (postgres, pgadmin), vault-secrets (kubectl), sonarqube, langflow, ollama (ollama/ollama), freeipa, github-runner (summerwind/*), mailu (bitnamilegacy/*, clamav, tika; Mailu org can be overridden to ghcr.io), plane-ce (valkey, postgres, rabbitmq, minio, busybox). **External charts:** Harbor (goharbor/*), Rancher (default system images), Gitea (upstream defaults), Bitnami Redis (bitnami/*). |
| **ghcr.io** | mailu (`imageRegistry: ghcr.io` → mailu/*), ollama (open-webui/open-webui), postgresql subchart cloudnative-pg (cloudnative-pg/cloudnative-pg). **External charts:** External Secrets Operator (ghcr.io/external-secrets/external-secrets — current default; some older chart versions may still use oci.external-secrets.io). |
| **quay.io** | github-runner (brancz/kube-rbac-proxy). **External charts:** cert-manager (quay.io/jetstack/*). |
| **artifacts.plane.so** | plane-ce (makeplane/plane-frontend, plane-space, plane-admin, plane-live, plane-backend). |
| **oci.external-secrets.io** | **External Secrets Operator** — legacy/proxy registry for ESO container images. Upstream chart may still reference it depending on version; current recommendation is ghcr.io/external-secrets/external-secrets. If you see ImagePullBackOff for ESO, override image to ghcr.io. |
| **registry.suse.com** | **Rancher** — audit log component can use registry.suse.com/bci/bci-micro (upstream default). |

---

## OCI / Helm chart registries

Registries used for **OCI Helm charts** (or chart references), not necessarily for container images.

| Registry | Where it's used |
|----------|------------------|
| **oci://registry-1.docker.io/bitnamicharts** | mailu subchart: redis chart dependency (Chart.yaml / Chart.lock). |
| **oci://quay.io/jetstack/charts/cert-manager** | cert-manager can be installed via OCI from quay.io (we use HTTPS chart repo https://charts.jetstack.io). |
| **oci.external-secrets.io** | Can be used as OCI registry for ESO Helm chart in some setups; we use HTTPS repo https://charts.external-secrets.io. |

---

## Helm chart repos (HTTP/HTTPS, not OCI)

For completeness — these are **chart** sources, not container image registries.

- https://swipentap.github.io/charts
- https://charts.external-secrets.io
- https://charts.jetstack.io
- https://helm.goharbor.io
- https://dl.gitea.com/charts/
- https://charts.bitnami.com/bitnami
- https://releases.rancher.com/server-charts/stable
- https://groundhog2k.github.io/helm-charts/
- https://mrnim94.github.io/redisinsight/
- https://github.com/devfile/devworkspace-operator
- https://eclipse-che.github.io/che-operator/charts (eclipse-che dependency)

---

## Summary: container image registries to consider for mirroring/proxy

1. **docker.io** (index.docker.io, registry-1.docker.io)
2. **ghcr.io**
3. **quay.io**
4. **artifacts.plane.so**
5. **oci.external-secrets.io** (ESO — legacy; prefer ghcr.io)
6. **registry.suse.com** (Rancher audit log)
