# Change Log

## 0.1.2 

**Release date:** 2024-03-14

![AppVersion: 1.16.0](https://img.shields.io/static/v1?label=AppVersion&message=1.16.0&color=success&logo=)
![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)


* PROT-16985 | fix cronjob args 
* Imrove readme 
* redefine target port 

### Default value changes

```diff
# No changes in this release
```

## 0.1.1 

**Release date:** 2024-02-26

![AppVersion: 1.16.0](https://img.shields.io/static/v1?label=AppVersion&message=1.16.0&color=success&logo=)
![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)


* Upgrade version 
* Fix ident 
* Fix ident 
* Fix overwrite 
* Add reloader support 

### Default value changes

```diff
# No changes in this release
```

## 0.1.0 

**Release date:** 2024-02-04

![AppVersion: 1.16.0](https://img.shields.io/static/v1?label=AppVersion&message=1.16.0&color=success&logo=)
![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)


* Downgrade the version 
* Rename externalsecret 
* fix ident 
* Add trim 
* Update _ServiceAccount.tpl add trim to labels 
* Some cleanup 
* feat(README): Update auto-generated READMEs [skip ci] 
* Add external secret / change deployemnt 
* commit local change 
* add end 
* Add somedoc 
* fix doc 
* Change lib 
* Rename file 
* Add support in default param 
* default port container 
* update labels 
* redefine cron name 
* Add doc 
* feat(README): Update auto-generated READMEs [skip ci] 

### Default value changes

```diff
diff --git a/charts/common-helm-lib/values.yaml b/charts/common-helm-lib/values.yaml
index 24260cf..72b7890 100644
--- a/charts/common-helm-lib/values.yaml
+++ b/charts/common-helm-lib/values.yaml
@@ -66,7 +66,7 @@ exports:
       annotations: {}
         # kubernetes.io/ingress.class: nginx
         # kubernetes.io/tls-acme: "true"
-       ## @section hosts  An array with additional hostname(s) to be covered with the ingress record".
+      ## @section hosts  An array with additional hostname(s) to be covered with the ingress record".
       hosts:
         ## @param exports.defaults.ingress.hosts[0].host
         ## @param exports.defaults.ingress.hosts[0].paths[0].path
@@ -186,6 +186,15 @@ exports:
       httpGet:
         path: /
         port: http
+    ## @section externalSecret".
+    ## @param exports.defaults.externalSecret.secretStoreName the name of the store
+    ## @param exports.defaults.externalSecret.secretStoreKind ( ClusterSecretStore/ SecretStore)
+    ## @param exports.defaults.externalSecret.refreshInterval intervale for external secret to refresh
+    externalSecret:
+      secretStoreName: ssm-aws
+      secretStoreKind: ClusterSecretStore
+      refreshInterval: 5m
+
     ## @param exports.defaults.deployment array of key value
     ## deployment:
     ##   api: (The deployment name)
```

## 0.1.3 

**Release date:** 2024-01-23

![AppVersion: 1.16.0](https://img.shields.io/static/v1?label=AppVersion&message=1.16.0&color=success&logo=)
![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)


* Change doc 

### Default value changes

```diff
diff --git a/charts/common-helm-lib/values.yaml b/charts/common-helm-lib/values.yaml
index 3e264f3..24260cf 100644
--- a/charts/common-helm-lib/values.yaml
+++ b/charts/common-helm-lib/values.yaml
@@ -138,9 +138,9 @@ exports:
       effect: "NoSchedule"
     ## @section exports.defaults.affinity
     ## @param exports.defaults.affinity.nodeAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].weight
-    ## @param exports.defaults.affinity.nodeAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.labelSelector.matchExpressions[0].eky
-    ## @param exports.defaults.affinity.nodeAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.labelSelector.matchExpressions[0].operator
-    ## @param exports.defaults.affinity.nodeAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.labelSelector.matchExpressions[0].values
+    ## @param exports.defaults.affinity.nodeAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].preference.matchExpressions[0].key
+    ## @param exports.defaults.affinity.nodeAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].preference.matchExpressions[0].operator
+    ## @param exports.defaults.affinity.nodeAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].preference.matchExpressions[0].values
     ## affinity:
     ##   podAntiAffinity:
     ##     preferredDuringSchedulingIgnoredDuringExecution:
```

## 0.1.4 

**Release date:** 2024-01-23

![AppVersion: 1.16.0](https://img.shields.io/static/v1?label=AppVersion&message=1.16.0&color=success&logo=)
![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)


* Fix doc 
* Fix doc 
* Fix doc 
* Fix doc 
* Add cronjob 
* define topology 
* add affinity per dep 

### Default value changes

```diff
diff --git a/charts/common-helm-lib/values.yaml b/charts/common-helm-lib/values.yaml
index 38945c0..3e264f3 100644
--- a/charts/common-helm-lib/values.yaml
+++ b/charts/common-helm-lib/values.yaml
@@ -115,18 +115,32 @@ exports:
       maxReplicas: 100
       targetCPUUtilizationPercentage: 80
       # targetMemoryUtilizationPercentage: 80
-    ## @param exports.defaults.nodeSelector
+    ## @section exports.defaults.nodeSelector
+    ## @param exports.defaults.nodeSelector.role
     ## nodeSelector:
     ##   role: eks-cluster
-    nodeSelector: {}
-    ## @param exports.defaults.tolerations
+    nodeSelector:
+      role: tikal
+    ## @section exports.defaults.tolerations
+    ## @param exports.defaults.tolerations[0].key
+    ## @param exports.defaults.tolerations[0].operator
+    ## @param exports.defaults.tolerations[0].value
+    ## @param exports.defaults.tolerations[0].effect
     ## tolerations:
     ## - key: intention
     ##   operator: Equal
     ##   value: eks-cluster-mgt
     ##   effect: NoSchedule
-    tolerations: []
-    ## @param exports.defaults.affinity
+    tolerations:
+    - key: "intention"
+      operator: "Equal"
+      value: "tikal"
+      effect: "NoSchedule"
+    ## @section exports.defaults.affinity
+    ## @param exports.defaults.affinity.nodeAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].weight
+    ## @param exports.defaults.affinity.nodeAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.labelSelector.matchExpressions[0].eky
+    ## @param exports.defaults.affinity.nodeAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.labelSelector.matchExpressions[0].operator
+    ## @param exports.defaults.affinity.nodeAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.labelSelector.matchExpressions[0].values
     ## affinity:
     ##   podAntiAffinity:
     ##     preferredDuringSchedulingIgnoredDuringExecution:
@@ -139,7 +153,25 @@ exports:
     ##                values:
     ##                - zookeeper
     ##          topologyKey: "topology.kubernetes.io/zone"
-    affinity: {}
+    affinity:
+      nodeAffinity:
+        preferredDuringSchedulingIgnoredDuringExecution:
+        - weight: 1
+          preference:
+            matchExpressions:
+            - key: eks.amazonaws.com/capacityType
+              operator: In
+              values:
+              - SPOT
+    ## @param exports.defaults.topologySpreadConstraints
+    ## topologySpreadConstraints:
+    ##   - maxSkew: 1
+    ##     topologyKey: "topology.kubernetes.io/zone"
+    ##     whenUnsatisfiable: DoNotSchedule
+    ##     labelSelector:
+    ##       matchLabels:
+    ##         app: kafkatohttp
+    topologySpreadConstraints: {}
     ## @section livenessProbe".
     ## @param exports.defaults.livenessProbe.httpGet.path (/) The path
     ## @param exports.defaults.livenessProbe.httpGet.port (http) the name of the port to listhen
@@ -171,3 +203,14 @@ exports:
     ##       # Overrides the image tag whose default is the chart appVersion.
     ##       tag: ""
     deployment: []
+    ## @param exports.defaults.cronjob array of key value
+    ## cronjob
+    ##   example:
+    ##     schedule: "*/10 * * * *"
+    ##     successfulJobsHistoryLimit: "1"
+    ##     failedJobsHistoryLimit: "2"
+    ##     restartPolicy: "OnFailure"
+    ##     container:
+    ##       image: busybox
+    ##       command: ["/bin/sh","-c","echo 'test'"]
+    cronjob: []
```

## 0.1.3 

**Release date:** 2024-01-23

![AppVersion: 1.16.0](https://img.shields.io/static/v1?label=AppVersion&message=1.16.0&color=success&logo=)
![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)


* Rename lib from common-lib to common-helm-lib 

### Default value changes

```diff
## @section exports".
exports:
  ## @section defaults".
  ## Default values for common-lib.
  ## This is a YAML-formatted file.
  ## Declare variables to be passed into your templates.
  defaults:
    ## @param exports.defaults.replicaCount [number, nullable] Description
    replicaCount: 1
    ## @section image".
    ## @param exports.defaults.image.repository  image repository
    ## @param exports.defaults.image.pullPolicy image pullPolicy
    ## @param exports.defaults.image.tag image tag
    image:
      repository: nginx
      pullPolicy: IfNotPresent
      # Overrides the image tag whose default is the chart appVersion.
      tag: ""
    ## @param exports.defaults.imagePullSecrets Image registry secret names as an array
    imagePullSecrets: []
    ## @param exports.defaults.nameOverride Default name override
    nameOverride: ""
     ## @param exports.defaults.fullnameOverride Default full name override
    fullnameOverride: ""
    ## @section serviceAccount".
    ## @param exports.defaults.serviceAccount.create  Enabled / Disabeld service acount
    ## @param exports.defaults.serviceAccount.annotations serviceAccount annotations
    ## @param exports.defaults.serviceAccount.name serviceAccount name
    serviceAccount:
      # Specifies whether a service account should be created
      create: true
      # Annotations to add to the service account
      annotations: {}
      # The name of the service account to use.
      # If not set and create is true, a name is generated using the fullname template
      name: ""
     ## @param exports.defaults.podAnnotations podAnnotations
    podAnnotations: {}
    ## @param exports.defaults.podSecurityContext podSecurityContext
    podSecurityContext: {}
      # fsGroup: 2000
    ## @param exports.defaults.securityContext securityContext
    securityContext: {}
      # capabilities:
      #   drop:
      #   - ALL
      # readOnlyRootFilesystem: true
      # runAsNonRoot: true
      # runAsUser: 1000
    ## @param exports.defaults.service - array of services such as: api, kafka
    ## api:
    ##   annotations: {}
    ##   type: ClusterIP
    ##   port: 80
    service: []
    ## @section ingress".
    ingress:
      ## @param exports.defaults.ingress.enabled Enable ingress record generation
      ##
      enabled: false
      ## @param exports.defaults.ingress.className IngressClass that will be be used to implement the Ingress (Kubernetes 1.18+)
      className: ""
      ## @param exports.defaults.ingress.annotations [object] Additional annotations for the Ingress resource. To enable certificate autogeneration, place here your cert-manager annotations.
      ## Use this parameter to set the required annotations for cert-manager, see
      ## ref: https://cert-manager.io/docs/usage/ingress/#supported-annotations
      annotations: {}
        # kubernetes.io/ingress.class: nginx
        # kubernetes.io/tls-acme: "true"
       ## @section hosts  An array with additional hostname(s) to be covered with the ingress record".
      hosts:
        ## @param exports.defaults.ingress.hosts[0].host
        ## @param exports.defaults.ingress.hosts[0].paths[0].path
        ## @param exports.defaults.ingress.hosts[0].paths[0].pathType
        ## - host: chart-example.local
        ##   paths:
        ##    - path: /
        ##      pathType: ImplementationSpecific
        - host: chart-example.local
          paths:
            - path: /
              pathType: ImplementationSpecific
      ## @param exports.defaults.ingress.tls TLS configuration for additional hostname(s) to be covered with this ingress record
      ## ref: https://kubernetes.io/docs/concepts/services-networking/ingress/#tls
      ## e.g:
      ## tls:
      ##  - secretName: chart-example-tls
      ##    hosts:
      ##     - chart-example.local
      ##
      tls: []
      #  - secretName: chart-example-tls
      #    hosts:
      #      - chart-example.local
    ## ref: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/
    ## @param exports.defaults.resources The resources limits/requests for the chart-example containers
    resources: {}
      # We usually recommend not to specify default resources and to leave this as a conscious
      # choice for the user. This also increases chances charts run on environments with little
      # resources, such as Minikube. If you do want to specify resources, uncomment the following
      # lines, adjust them as necessary, and remove the curly braces after 'resources:'.
      # limits:
      #   cpu: 100m
      #   memory: 128Mi
      # requests:
      #   cpu: 100m
      #   memory: 128Mi
    ## @section autoscaling".
    ## @param exports.defaults.autoscaling.enabled Enabled/Disabeld thew hpa
    ## @param exports.defaults.autoscaling.minReplicas Min number of replicas
    ## @param exports.defaults.autoscaling.maxReplicas Max number of replicas
    ## @param exports.defaults.autoscaling.targetCPUUtilizationPercentage The cpu metrcis that cause the scaleup
    autoscaling:
      enabled: false
      minReplicas: 1
      maxReplicas: 100
      targetCPUUtilizationPercentage: 80
      # targetMemoryUtilizationPercentage: 80
    ## @param exports.defaults.nodeSelector
    ## nodeSelector:
    ##   role: eks-cluster
    nodeSelector: {}
    ## @param exports.defaults.tolerations
    ## tolerations:
    ## - key: intention
    ##   operator: Equal
    ##   value: eks-cluster-mgt
    ##   effect: NoSchedule
    tolerations: []
    ## @param exports.defaults.affinity
    ## affinity:
    ##   podAntiAffinity:
    ##     preferredDuringSchedulingIgnoredDuringExecution:
    ##      - weight: 100
    ##        podAffinityTerm:
    ##          labelSelector:
    ##            matchExpressions:
    ##              - key: "component"
    ##                operator: In
    ##                values:
    ##                - zookeeper
    ##          topologyKey: "topology.kubernetes.io/zone"
    affinity: {}
    ## @section livenessProbe".
    ## @param exports.defaults.livenessProbe.httpGet.path (/) The path
    ## @param exports.defaults.livenessProbe.httpGet.port (http) the name of the port to listhen
    livenessProbe:
      httpGet:
        path: /
        port: http
    ## @section readinessProbe".
    ## @param exports.defaults.readinessProbe.httpGet.path (/) The path
    ## @param exports.defaults.readinessProbe.httpGet.port (http) the name of the port to listhen
    readinessProbe:
      httpGet:
        path: /
        port: http
    ## @param exports.defaults.deployment array of key value
    ## deployment:
    ##   api: (The deployment name)
    ##     envFrom:
    ##       - configMapRef:
    ##           name: my-config
    ##       - secretRef:
    ##           name: my-secret
    ##     env:
    ##       - name: environment
    ##         value: default
    ##     image:
    ##       repository: nginx
    ##       pullPolicy: IfNotPresent
    ##       # Overrides the image tag whose default is the chart appVersion.
    ##       tag: ""
    deployment: []
```

---
Autogenerated from Helm Chart and git history using [helm-changelog](https://github.com/mogensen/helm-changelog)
