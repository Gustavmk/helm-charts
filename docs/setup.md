# Repository setup

One-time steps to turn this repository into a working Helm chart repository.
After this is done, publishing is fully automated by the
[`Release Charts`](../.github/workflows/release.yml) workflow.

## 1. Create the `gh-pages` branch

`chart-releaser` publishes packaged charts and the `index.yaml` to a
`gh-pages` branch. Create it once as an empty branch:

```sh
git checkout --orphan gh-pages
git rm -rf .
git commit --allow-empty -m "Initialize gh-pages"
git push origin gh-pages
git checkout main
```

## 2. Enable GitHub Pages

In **Settings → Pages**, set the source to **Deploy from a branch** and choose
the `gh-pages` branch (root folder). The published site is the URL clients pass
to `helm repo add`.

## 3. Grant the workflow write access

In **Settings → Actions → General → Workflow permissions**, select
**Read and write permissions**. This lets the workflow push to `gh-pages` and
create releases using the default `GITHUB_TOKEN` (the workflow already requests
`contents: write` and `packages: write`).

## 4. Publishing workflow

[`.github/workflows/release.yml`](../.github/workflows/release.yml) runs on every
push to `main`. It checks each chart's `version` in `Chart.yaml`; when a version
has not been released yet, it packages the chart, uploads it to the `gh-pages`
branch, regenerates `index.yaml`, and creates a GitHub release for that version.

## 5. Bump the chart version on every change

`chart-releaser` skips any chart whose `version` already has a release, so a
new `version` value in `Chart.yaml` is required for each change. Increment it
following [Semantic Versioning](https://semver.org/):

- patch — template fixes, no behavioural change for users;
- minor — new values or optional features, backwards compatible;
- major — breaking changes to values or rendered manifests.

`appVersion` should track the upstream application image tag and does not need
to follow SemVer.
