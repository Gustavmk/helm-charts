# helm-charts

Personal Helm chart repository, published via GitHub Pages and hosted at
`https://drylabs.dev/helm-charts/`.

## Available charts

| Chart | Description |
| ----- | ----------- |
| `dotnet-boilerplate-api` | Deploys the [dotnet-api-boilerplate](https://github.com/gustavmk/dotnet-api-boilerplate) service to Kubernetes. |

## Usage

1. Add the repository:

   ```sh
   helm repo add gustavmk-charts https://drylabs.dev/helm-charts/
   ```

2. Refresh the local cache:

   ```sh
   helm repo update
   ```

3. Search for available charts:

   ```sh
   helm search repo gustavmk-charts
   ```

4. Install a chart:

   ```sh
   helm install my-api gustavmk-charts/dotnet-boilerplate-api
   ```

   Override defaults with your own values file:

   ```sh
   helm install my-api gustavmk-charts/dotnet-boilerplate-api -f my-values.yaml
   ```

## Development

- Chart sources live under [`charts/`](charts/).
- Lint a chart before committing: `helm lint charts/<name>`.
- Render templates locally: `helm template test charts/<name>`.
- Every push to `main` runs [`chart-releaser`](.github/workflows/release.yml),
  which packages any chart whose `version` in `Chart.yaml` changed, pushes the
  packaged archive plus an updated `index.yaml` to the `gh-pages` branch, and
  creates a matching GitHub release.

See [`docs/setup.md`](docs/setup.md) for the one-time repository setup.
