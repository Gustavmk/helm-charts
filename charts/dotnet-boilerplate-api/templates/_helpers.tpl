{{/*
Expand the name of the chart.
*/}}
{{- define "dotnet-boilerplate-api.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "dotnet-boilerplate-api.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "dotnet-boilerplate-api.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "dotnet-boilerplate-api.labels" -}}
helm.sh/chart: {{ include "dotnet-boilerplate-api.chart" . }}
{{ include "dotnet-boilerplate-api.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "dotnet-boilerplate-api.selectorLabels" -}}
app.kubernetes.io/name: {{ include "dotnet-boilerplate-api.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Name of the Secret holding sensitive environment variables.
*/}}
{{- define "dotnet-boilerplate-api.secretName" -}}
{{- default (include "dotnet-boilerplate-api.fullname" .) .Values.secret.name }}
{{- end }}

{{/*
Fully qualified name of the bundled PostgreSQL resources.
*/}}
{{- define "dotnet-boilerplate-api.postgresql.fullname" -}}
{{- printf "%s-postgresql" (include "dotnet-boilerplate-api.fullname" .) | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
PostgreSQL selector labels.
*/}}
{{- define "dotnet-boilerplate-api.postgresql.selectorLabels" -}}
app.kubernetes.io/name: {{ include "dotnet-boilerplate-api.name" . }}-postgresql
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: database
{{- end }}

{{/*
PostgreSQL common labels.
*/}}
{{- define "dotnet-boilerplate-api.postgresql.labels" -}}
helm.sh/chart: {{ include "dotnet-boilerplate-api.chart" . }}
{{ include "dotnet-boilerplate-api.postgresql.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Name of the Secret holding the PostgreSQL password.
*/}}
{{- define "dotnet-boilerplate-api.postgresql.secretName" -}}
{{- if .Values.postgresql.auth.existingSecret }}
{{- .Values.postgresql.auth.existingSecret }}
{{- else }}
{{- include "dotnet-boilerplate-api.postgresql.fullname" . }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "dotnet-boilerplate-api.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "dotnet-boilerplate-api.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
