{{/*
Create the name of the service account to use
*/}}
{{- define "common-lib.deployment" -}}
{{- $root_context := index . 0 }}
{{- $current_context := index . 1 }}
{{- $custom_name := index . 2 }}
{{- $deployment := $current_context.Values.deployment }}
{{- $values := $current_context.Values }}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: "{{ $custom_name }}"
  labels:
    {{- include "common-lib.labels" (list $root_context $custom_name) | trim | nindent 4 }}
spec:
  {{- with index $current_context.Values.deployment $custom_name }}
  {{- if not $values.autoscaling.enabled }}
  replicas: {{ .replicaCount | default 1 }}
  {{- end }}
  selector:
    matchLabels:
      {{- include "common-lib.selectorLabels" (list $root_context $custom_name) | trim | nindent 6 }}
  template:
    metadata:
      annotations:
      {{- range $envFrom := .envFroms }}
        {{ with $a := index $envFrom "envFrom" -}}
           {{- if hasKey (index $a 0)  "configMapRef" -}}
        configmap.reloader.stakater.com/reload: "{{ ( index (index $a 0) "configMapRef").name }}"
          {{- end }}
          {{- if hasKey (index $a 0)  "secretRef" -}}
        secret.reloader.stakater.com/reload: "{{ ( index (index $a 0) "secretRef").name }}"
          {{- end }}
        {{- end }}
      {{- end }}
      labels:
        {{- include "common-lib.selectorLabels" (list $root_context $custom_name ) | trim | nindent 8 }}
    spec:
     {{- with $values.imagePullSecrets }}
      imagePullSecrets:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      serviceAccountName: {{ include "common-lib.serviceAccountName" (list $root_context) }}
      securityContext:
       {{- toYaml $values.podSecurityContext | nindent 8 }}
      containers:
        - name: {{ $custom_name }}
          securityContext:
          {{- toYaml .securityContext | nindent 12 }}
          image: '{{ .image.repository }}:{{ .image.tag | default $root_context.Chart.AppVersion }}'
          {{- range  .envFroms }}
            {{- toYaml . | nindent 10 }}
          {{- end }}
          imagePullPolicy: {{ $values.image.pullPolicy }}
          volumeMounts:
            {{- toYaml $values.volumeMounts | nindent 12 }}
          ports:
            - name: http
              containerPort: {{ .containerPort | default 80 }}
              protocol: TCP
          livenessProbe:
            {{- toYaml .livenessProbe | nindent 12 }}
          readinessProbe:
            {{- toYaml .readinessProbe | nindent 12 }}
          resources:
            {{- toYaml .resources | nindent 12 }}
      volumes:
        {{- toYaml $values.volumes | nindent 8 }}
      nodeSelector:
        {{- toYaml $values.nodeSelector | nindent 8 }}
      affinity:
        {{- toYaml $values.affinity | nindent 8 }}
      tolerations:
        {{- toYaml $values.tolerations | nindent 8 }}
      {{- if $values.critical.enabled }}
      priorityClassName: system-cluster-critical
      {{- end }}
      topologySpreadConstraints:
        - maxSkew: 1
          topologyKey: "topology.kubernetes.io/zone"
          whenUnsatisfiable: DoNotSchedule
          labelSelector:
            matchLabels:
              app: {{ $custom_name }}
  {{- end }}
{{- end }}
