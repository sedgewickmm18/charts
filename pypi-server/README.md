# PyPi Server Helm Chart

This chart installs a PyPI server as a StatefulSet with a shared Persistent Volume across replicas.

## Prerequisites Details

- Kubernetes 1.6+
- Persistent Volume `ReadWriteMany` support for default storageClass or specified by `persistence.storageClassName`
- Ingress plugin: Required if `ingress.enabled`

## Adding the repo

To add the repo to helm with the name `cgsimmons`:

```bash
$ helm repo add cgsimmons https://cgsimmons.github.io/charts
```

## Installing the Chart

To install the chart with the release name `my-pypi`:

```bash
$ helm install my-pypi cgsimmons/pypi-server
```

## Upgrading the Charts

```bash
$ helm upgrade my-pypi cgsimmons/pypi-server
```

## Configuration

The following tables lists the configurable parameters of the PyPI server chart and their default values.

| Parameter                                       | Description                                                                              | Default                 |
| ----------------------------------------------- | ---------------------------------------------------------------------------------------- | ----------------------- |
| `nameOverride`                                  | Partial name override, combines with release name                                        | `""`                    |
| `fullnameOverride`                              | Complete name override                                                                   | `""`                    |
| `container.securityContext`                     | Security context at the container level                                                  | `{}`                    |
| `container.resources`                           | Resources configuration                                                                  | `{}`                    |
| `image.repository`                              | Container image repository                                                               | `pypiserver/pypiserver` |
| `image.pullPolicy`                              | Container pull policy                                                                    | `IfNotPresent`          |
| `image.tag`                                     | Container image name                                                                     | `v1.3.2`                |
| `imagePullSecrets`                              | Secrets for image pull                                                                   | `[]`                    |
| `pod.replicas`                                  | Pod replica count                                                                        | `2`                     |
| `pod.labels`                                    | Extra labels applied to the pod                                                          | `{}`                    |
| `pod.annotations`                               | Extra annotations applied to the pod                                                     | `{}`                    |
| `pod.securityContext`                           | Security context on pod level                                                            | `{}`                    |
| `pod.nodeSelector`                              | Node selector of the deployment                                                          | `{}`                    |
| `pod.tolerations`                               | Tolerations configuration for the deployment                                             | `[]`                    |
| `pod.affinity`                                  | Affinity of the deployment                                                               | `nil`                   |
| `service.port`                                  | Service port                                                                             | `80`                    |
| `service.annotations`                           | Service annotations                                                                      | `{}`                    |
| `service.labels`                                | Service labels                                                                           | `{}`                    |
| `ingress.enabled`                               | Ingress configuration flag                                                               | `false`                 |
| `ingress.labels`                                | Ingress labels                                                                           | `{}`                    |
| `ingress.annotations`                           | Ingress annotations                                                                      | `{}`                    |
| `ingress.path`                                  | Ingress path                                                                             | `nil`                   |
| `ingress.hosts`                                 | Ingress hosts                                                                            | `[]`                    |
| `ingress.tls`                                   | Ingress TLS configuration                                                                | `[]`                    |
| `server.extraArgs`                              | Additional arguments (beside -P, -p, -a) to be passed to the underyling pypiserver image | `[]`                    |
| `auth.actions`                                  | Actions requiring authentication (comma separated list)                                  | `list,download,update`  |
| `auth.credentials`                              | Map of username / encoded password to write in a htpasswd (if not provided)              | `{admin: admin}`        |
| `auth.secretName`                               | A secret containing auth credentials as an alternative to passing auth.credentials       | `nil`                   |
| `auth.secretKey`                                | The secret key containing the auth credentials                                           | `auth`                  |
| `persistence.storageClassName`                  | Persistence storage class name                                                           | `nil`                   |
| `persistence.existingClaim`                     | Persistent volume claim static name                                                      | `nil`                   |
| `persistence.size`                              | Persistence volume size                                                                  | `5Gi`                   |
| `autoscaling.enabled`                           | Enable autoscaling                                                                       | `false`                 |
| `autoscaling.minReplicas`                       | Minimum replicas                                                                         | `2`                     |
| `autoscaling.maxReplicas`                       | Maximum replicas                                                                         | `10`                    |
| `autoscaling.targetCPUUtilizationPercentage`    | CPU usage percentage threshold for autoscaling                                           | `80`                    |
| `autoscaling.targetMemoryUtilizationPercentage` | Memory usage percentage threshold for autoscaling                                        | `nil`                   |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install` or build your own config based on the `values.yaml` and pass the path via `--set-file <path to file>`

## Affinity Details
The default affinity will be to prefer not sharing a node with pods of the same statefulset. This is to maximize availability should a node fail. Setting the `pod.affinity` parameter will override these settings.