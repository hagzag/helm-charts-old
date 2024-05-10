{{- define "common-lib.externalsecret" -}}
{{- $root_context := index . 0 }}
{{- $current_context := index . 1 }}
{{- $custom_name := index . 2 }}
{{- $data := include (printf "secret.mydata.%s" $custom_name) $current_context | fromYaml -}}
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: ex{{ $custom_name }}
spec:
  refreshInterval: {{ $current_context.Values.externalSecret.refreshInterval }}
  secretStoreRef:
    name: {{ $current_context.Values.externalSecret.secretStoreName }} # ssm-aws #The secret store name we have just created.
    kind: {{ $current_context.Values.externalSecret.secretStoreKind }} # ClusterSecretStore
  target:
    name: {{ $custom_name }}{{println }}
{{- toYaml $data | nindent 2 }}
{{- end -}}
