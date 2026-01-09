# CockroachDB Helm Chart

A Helm chart for deploying CockroachDB - a distributed SQL database.

## Installation

```bash
helm install cockroachdb ./cockroachdb
```

## Configuration

The following table lists the configurable parameters:

| Parameter | Description | Default |
|-----------|-------------|---------|
| `cockroachdb.image.repository` | CockroachDB image repository | `cockroachdb/cockroach` |
| `cockroachdb.image.tag` | CockroachDB image tag | `v23.2.0` |
| `cockroachdb.replicaCount` | Number of CockroachDB replicas | `1` |
| `cockroachdb.service.type` | Service type | `ClusterIP` |
| `cockroachdb.service.httpPort` | HTTP port for admin UI | `8080` |
| `cockroachdb.service.sqlPort` | SQL port | `26257` |
| `cockroachdb.persistence.enabled` | Enable persistence | `true` |
| `cockroachdb.persistence.size` | Storage size | `20Gi` |

## Access

- SQL: `cockroachdb-0.cockroachdb:26257`
- Admin UI: `http://cockroachdb-0.cockroachdb:8080`
