{{/*
Create the service account to use
*/}}
{{- define "common-lib.serviceAccount" -}}
{{- $root_context := index . 0 }}
apiVersion: v1
kind: ServiceAccount
metadata:
  name: {{ include "common-lib.serviceAccountName" (list $root_context) }}
  labels:
    {{ include "common-lib.labels" (list $root_context (include "common-lib.name" (list $root_context))) | trim | nindent 4 }}
  {{- with $root_context.Values.serviceAccount.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
    argocd.argoproj.io/hook: PreSync
  {{- end }}
 {{end}}
