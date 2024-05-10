{{/*
Create KEDA
*/}}
{{- define "common-lib.kedaautoscaler" -}}
{{- $root_context := index . 0 }}
{{- $current_context := index . 1 }}
{{- $custom_name := index . 2 }}
{{- $fullName := include "common-lib.fullname" . -}}
{{- $values := $current_context.Values }}
{{- with index $values "kedaautoscaler"  }}
apiVersion: keda.sh/v1alpha1
kind: ScaledObject
metadata:
  name: {{ .name | default $custom_name }}
  labels:
    {{- include "common-lib.labels" (list $root_context $custom_name) | trim | nindent 4 }}
  annotations:
    {{- toYaml .annotations | nindent 4 }}
spec:
  scaleTargetRef:
    kind: {{ .kind | default "Deployment" }}
    name: {{ .name | default $custom_name }}
  pollingInterval:  {{ .pollingInterval }}
  cooldownPeriod: {{ .cooldownPeriod }}
  minReplicaCount: {{ .minReplicaCount }}
  maxReplicaCount: {{ .maxReplicaCount }}
  {{- if .advanced }}
  advanced: {{- toYaml .advanced | nindent 4 }}
  {{- end }}
  triggers: {{- toYaml .triggers | nindent 4 }}
{{- end }}
{{- end }}
