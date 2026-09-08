# dotnet-boilerplate-api

Helm chart that deploys the
[dotnet-api-boilerplate](https://github.com/Gustavmk/dotnet-api-boilerplate)
service to Kubernetes.

## What it deploys

- A `Deployment` for the API, exposed through a `Service` (and optionally
  `Ingress` or a Gateway API `HTTPRoute`).
- An optional `Secret` (`secret.create`) holding sensitive environment
  variables such as the DB connection string, injected via `envFrom`.
- An optional in-cluster PostgreSQL `StatefulSet` (`postgresql.enabled`) for
  dev/test.

## PostgreSQL

Enabling `postgresql.enabled` renders a single-replica `StatefulSet`, a
`ClusterIP` `Service`, and a `Secret` with the database password (unless
`postgresql.auth.existingSecret` is set). Data is kept on a PVC created from a
`volumeClaimTemplate` (`postgresql.persistence`).

It is intended for local and small self-contained deployments. For production,
disable it and use a managed database or a dedicated operator.

Point the API at the bundled database via `secret.stringData`:

```yaml
postgresql:
  enabled: true
  auth:
    username: app_user
    database: HeroDb
    password: "s3cr3t"

secret:
  create: true
  stringData:
    ConnectionStrings__DefaultConnection: "Host=my-release-dotnet-boilerplate-api-postgresql;Port=5432;Database=HeroDb;Username=app_user;Password=s3cr3t"
```

See [`values.yaml`](values.yaml) for all options.
