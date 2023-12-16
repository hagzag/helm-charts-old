# helm-charts

A helm chart repository - `./charts` folder will be used to store helm chart needed by the labs project
his functionality is in beta and is subject to change. The code is provided as-is with no warranties. Beta features are not subject to the support SLA of official GA features.

## OCI Usage

Helm must be installed to use the charts. Please refer to Helm's documentation to get started.

Get the common chart (note that `/charts/common` doesn't have a ./templates folder)

```sh
git clone git@github.com:hagzag/helm-charts.git
cd helm-charts/charts/common
helm dep update --skip-refresh
```

Should yield:

```sh
Saving 1 charts
Downloading common from repo oci://ghcr.io/hagzag/charts
Pulled: ghcr.io/hagzag/charts/common:0.2.0
Digest: sha256:e3e1bd9ed3ade825f4e0911e18203cafcea23f236d5572d59124759981174099
Deleting outdated charts
```
You should see the `./charts` filder with `common-${version}.tgz`
If you don't try to ghcr login: `echo $GITHUB_TOKEN | docker login ghcr.io -u <GITHUB_USER> --password-stdin`
