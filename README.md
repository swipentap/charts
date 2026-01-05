# Helm Charts Repository

Popular applications ready to launch on Kubernetes using Helm.

## TL;DR

```bash
helm repo add swipentap https://swipentap.github.io/charts
helm repo update
helm install my-release swipentap/<chart>
```

## Before you begin

### Prerequisites

* Kubernetes 1.23+
* Helm 3.8.0+

### Install Helm

Helm is a tool for managing Kubernetes charts. Charts are packages of pre-configured Kubernetes resources.

To install Helm, refer to the [Helm install guide](https://helm.sh/docs/intro/install/) and ensure that the `helm` binary is in the `PATH` of your shell.

### Using Helm

Once you have installed the Helm client, add this repository:

```bash
helm repo add swipentap https://swipentap.github.io/charts
helm repo update
```

You can then search for available charts:

```bash
helm search repo swipentap
```

Useful Helm Client Commands:

* Install a chart: `helm install my-release swipentap/<chart>`
* Upgrade your application: `helm upgrade my-release swipentap/<chart>`
* List installed releases: `helm list`
* Uninstall a release: `helm uninstall my-release`

## Available Charts

* **ollama** - Ollama LLM server with optional WebUI
* **sins** - SiNS (Simple Name Server) - DNS server with web management interface

## License

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

<http://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
