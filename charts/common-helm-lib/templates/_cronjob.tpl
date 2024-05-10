{{/*
Create the name of the service account to use
*/}}
{{- define "common-lib.cronjob" -}}
{{- $root_context := index . 0 }}
{{- $current_context := index . 1 }}
{{- $custom_name := index . 2 }}
{{- with index $current_context.Values.cronjob $custom_name }}
apiVersion: batch/v1
kind: CronJob
metadata:
  name: "{{ $custom_name }}-cronjob"
  annotations:
    {{- toYaml .annotations | nindent 4 }}
spec:
  schedule: "{{ .schedule | default "* * * * *" }}"
  successfulJobsHistoryLimit: {{ .successfulJobsHistoryLimit | default 1 }}
  failedJobsHistoryLimit: {{ .failedJobsHistoryLimit | default 1 }}
  jobTemplate:
    spec:
    {{ with .jobTemplate }}
    {{ toYaml .spec | nindent 6 }}
    {{- end }}
      template:
        spec:
          nodeSelector: {{ $current_context.Values.nodeSelector | toYaml | nindent 12  }}
          tolerations: {{ $current_context.Values.tolerations | toYaml | nindent 12 }}
          affinity: {{ $current_context.Values.affinity | toYaml | nindent 12  }}
          {{- range .podTopologySpread }}
          topologySpreadConstraints:
          {{- toYaml . | nindent 12 }}
          {{- end }}
          containers:
            - name: {{ $custom_name }}
            {{- if .container.image }}
              image: "{{ .container.image  }}"
            {{- else }}
              image: "{{ (index $current_context.Values.deployment $current_context.Chart.Name ).image.repository }}:{{ (index $current_context.Values.deployment $current_context.Chart.Name ).image.tag }}"
            {{- end }}
            {{- range  .envFroms }}
              {{- toYaml . | nindent 14 }}
            {{- end }}
              resources:
            {{- if .container.resources }}
            {{- toYaml .container.resources | nindent 16 }}
            {{- else }}
                requests:
                  cpu: "10m"
                  memory: "30Mi"
            {{- end }}
              command: {{- range .container.command }}
                       - {{.}}{{- end }}
          restartPolicy: {{ .restartPolicy | default "OnFailure" }}
    {{- end }}
{{- end }}
