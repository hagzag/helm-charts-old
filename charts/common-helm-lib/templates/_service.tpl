{{/*
Create the name of the service account to use
*/}}
{{- define "common-lib.service" -}}
{{- $root_context := index . 0 }}
{{- $current_context := index . 1 }}
{{- $custom_name := index . 2 }}
apiVersion: v1
kind: Service
metadata:
  name: {{ $custom_name }}
  labels:
    {{- include "common-lib.labels" (list $root_context $custom_name)| trim  | nindent 4 }}
  {{- with index $current_context.Values.service $custom_name "annotations"  }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  {{- with index $current_context.Values.service $custom_name }}
  type: {{ .type | default "ClusterIP" }}
  ports:
    {{- if .ports }}
    {{- range .ports }}
    - port: {{ .port | default "80" }}
      targetPort: {{ .targetPort | default "8080" }}
      protocol: TCP
      name: {{ .name | default "http" }}
    {{- end}}
    {{- else }}
    - port: {{ .port | default "80" }}
      targetPort: {{ .targetPort | default "8080" }}
      protocol: TCP
      name: {{ .name | default "http" }}
    {{- end}}
  selector:
    {{- include "common-lib.selectorLabels" (list $root_context $custom_name) | trim | nindent 4 }}
  {{- end }}
 {{end}}
