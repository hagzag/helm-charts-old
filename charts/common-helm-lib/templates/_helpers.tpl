{{/*
Expand the name of the chart.
*/}}
{{- define "common-lib.name" -}}
{{- $root_context := index . 0 }}
{{- default $root_context.Chart.Name $root_context.Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "common-lib.fullname" -}}
{{- $root_context := index . 0 }}
{{- if $root_context.Values.fullnameOverride }}
{{- $root_context.Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default $root_context.Chart.Name $root_context.Values.nameOverride }}
{{- if contains $name $root_context.Release.Name }}
{{- $root_context.Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" $root_context.Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "common-lib.chart" -}}
{{- $root_context := index . 0 }}
{{- printf "%s-%s" $root_context.Chart.Name $root_context.Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "common-lib.labels" -}}
{{- $root_context := index . 0 }}
{{- $custom_name := index . 1 }}
helm.sh/chart: {{ include "common-lib.chart" (list $root_context) | trim }}
{{ include "common-lib.selectorLabels" (list $root_context $custom_name) | trim }}
{{- if $root_context.Chart.AppVersion }}
app.kubernetes.io/version: {{ $root_context.Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ $root_context.Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "common-lib.selectorLabels" -}}
{{- $root_context := index . 0 }}
{{- $custom_name := index . 1 }}
app.kubernetes.io/name: {{ $custom_name }}
app.kubernetes.io/instance: {{ $custom_name }}
app: {{ $custom_name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "common-lib.serviceAccountName" -}}
{{- $root_context := index . 0 }}
{{- if $root_context.Values.serviceAccount.create }}
{{- default (include "common-lib.fullname" (list $root_context)) $root_context.Values.serviceAccount.name }}
{{- else }}
{{- printf "default" }}
{{- end }}
{{- end }}


{{/*
Default configuration
*/}}
{{- define "common-lib.baseConfig" -}}
{{- $root_context := index . 0 }}
data:
  AWS_DEFAULT_REGION: {{ $root_context.Values.region }}
  AWS_REGION: {{ $root_context.Values.region }}
  ENVIRONMENT: {{ $root_context.Values.env }}
{{- end }}
