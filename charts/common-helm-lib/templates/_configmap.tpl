{{- define "common-lib.configmap" -}}
{{- $root_context := index . 0 }}
{{- $current_context := index . 1 }}
{{- $custom_name := index . 2 }}
{{- $baseConfig := include "common-lib.baseConfig" (list $root_context) | fromYaml -}}
{{- $overrides := include (printf "config.mydata.%s" $custom_name) $current_context | fromYaml -}}
{{- $mergedConfig := mustMergeOverwrite (dict) $baseConfig $overrides -}}
apiVersion: v1
kind: ConfigMap
metadata:
  annotations:
    argocd.argoproj.io/hook: PreSync
  name: {{ $custom_name }}{{println }}
{{- toYaml $mergedConfig  }}
{{- end -}}
