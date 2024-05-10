{{/*
Create the service account to use
*/}}
{{- define "common-lib.ingress" -}}
{{- $root_context := index . 0 }}
{{- $current_context := index . 1 }}
{{- $custom_name := index . 2 }}
{{- $fullName := include "common-lib.fullname" . -}}
{{- $values := $current_context.Values }}
{{- with index $values "ingress"  }}
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ .name | default $fullName }}
  labels:
    {{- include "common-lib.labels" (list $root_context $custom_name) | trim | nindent 4 }}
  annotations:
    {{- toYaml .annotations | nindent 4 }}
spec:
  defaultBackend:
    service:
      name: {{ $custom_name }}
      port:
        number: 80
  ingressClassName: {{ .className | default "alb" }}
  rules:
  {{- range .hosts }}
  - http:
    {{- range .paths }}
      paths:
      - backend:
          service:
            name: {{ $custom_name }}
            port:
              number: 80
        path: {{ .path }}
        pathType: {{ .pathType | quote | default "Prefix" }}
    {{- end}}
  {{- end}}
{{- end}}
{{- end}}
