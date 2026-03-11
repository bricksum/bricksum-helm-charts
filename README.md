# Bricksum Helm Charts

Helm chart repository for Bricksum projects. Charts are automatically packaged and published to GitHub Pages via the chart-releaser action.

## Usage

### Add the Helm repository

```bash
helm repo add bricksum https://<username>.github.io/bricksum-helm-charts
helm repo update
```

### Install the Cluma chart

```bash
helm install cluma bricksum/cluma -n cluma-system --create-namespace
```

See [charts/cluma](charts/cluma) for chart-specific documentation and the full `values.yaml` reference.

## Key Parameters

| Parameter | Description | Default |
|---|---|---|
| `global.nodeIP` | Kubernetes node IP (auto-detect if empty) | `""` |
| `frontend.image.tag` | Frontend image tag | `"v0.0.1"` |
| `backend.image.tag` | Backend image tag | `"v0.0.1"` |
| `ingress.enabled` | Enable ingress | `true` |
| `ingress.host` | Ingress hostname | `cluma.internal` |
| `persistence.storageType` | Storage type (`hostpath` or `nfs-csi`) | `nfs-csi` |
| `persistence.storageClass` | Default storage class | `nfs-csi` |
| `postgresql.persistence.size` | PostgreSQL volume size | `20Gi` |
| `registry.persistence.size` | Docker registry volume size | `50Gi` |
| `registry.service.nodePort` | Registry NodePort | `32000` |
