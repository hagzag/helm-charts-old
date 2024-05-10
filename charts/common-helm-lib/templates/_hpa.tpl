{{/*
Create HPA
*/}}
{{- define "common-lib.autoscaling" -}}
{{- $root_context := index . 0 }}
{{- $current_context := index . 1 }}
{{- $custom_name := index . 2 }}
{{- $fullName := include "common-lib.fullname" . -}}
{{- $values := $current_context.Values }}
{{- with index $values "autoscaling"  }}

apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: {{ .name | default $custom_name }}
  labels:
    {{- include "common-lib.labels" (list $root_context $custom_name) | trim | nindent 4 }}
  annotations:
    {{- toYaml .annotations | nindent 4 }}
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: {{ .kind | default "Deployment" }}
    name: {{ .name | default $custom_name }}
  minReplicas: {{ .minReplicaCount }}
  maxReplicas: {{ .maxReplicaCount }}
  metrics: {{- toYaml .metrics | nindent 4 }}
  {{- with .behavior }}
  behavior: {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end }}
{{- end }}
