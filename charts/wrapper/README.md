# wrapper

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.16.0](https://img.shields.io/badge/AppVersion-1.16.0-informational?style=flat-square)

A Helm chart for Kubernetes

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../common | api(common) | 0.1.0 |
| file://../common | worker(common) | 0.1.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| api.args[0] | string | `"poetry"` |  |
| api.args[1] | string | `"run"` |  |
| api.args[2] | string | `"uvicorn"` |  |
| api.args[3] | string | `"src.api.main:app"` |  |
| api.args[4] | string | `"--host"` |  |
| api.args[5] | string | `"0.0.0.0"` |  |
| api.args[6] | string | `"--port"` |  |
| api.args[7] | int | `9090` |  |
| api.enabled | bool | `true` |  |
| api.fullnameOverride | string | `"api"` |  |
| api.service.enabled | bool | `true` |  |
| api.service.port | int | `9090` |  |
| global.image.repository | string | `"ghcr.io/hagzag/keda-poc"` |  |
| global.image.tag | string | `"v1.3.1"` |  |
| worker.args[0] | string | `"poetry"` |  |
| worker.args[1] | string | `"run"` |  |
| worker.args[2] | string | `"uvicorn"` |  |
| worker.args[3] | string | `"src.worker.main:app"` |  |
| worker.args[4] | string | `"--host"` |  |
| worker.args[5] | string | `"0.0.0.0"` |  |
| worker.args[6] | string | `"--port"` |  |
| worker.args[7] | int | `8080` |  |
| worker.enabled | bool | `true` |  |
| worker.fullnameOverride | string | `"worker"` |  |
| worker.replicaCount | int | `0` |  |
| worker.service.enabled | bool | `true` |  |
| worker.service.port | int | `8080` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.2](https://github.com/norwoodj/helm-docs/releases/v1.11.2)