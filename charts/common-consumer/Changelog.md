# Change Log

## Next Release 

![AppVersion: 1.16.0](https://img.shields.io/static/v1?label=AppVersion&message=1.16.0&color=success&logo=)
![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)


* Fix dep 
* feat(README): Update auto-generated READMEs [skip ci] 
* fix doc 
* Dox 
* Fix doc 
* FIX DOC 
* Upgrade version 
* Change value 
* Fix ident 
* Add reloader support 
* Change version 
* feat(README): Update auto-generated READMEs [skip ci] 
* fix doc 
* Change dependency 
* Clean 
* Add support in default param 
* Add doc 
* feat(README): Update auto-generated READMEs [skip ci] 
* Change doc 
* Fix doc 
* Fix doc 
* Fix doc 
* Fix doc 
* Add cronjob 
* redefine common helm lib for test 
* feat(README): Update auto-generated READMEs [skip ci] 
* Fix doc 
* Fix lint 
* Upgrade dep 
* Fix example 
* feat(README): Update auto-generated READMEs [skip ci] 
* Clean trim 
* feat(README): Update auto-generated READMEs [skip ci] 
* Read me 
* add custom deployment and service 
* Add readme 
* Add doc 
* Add doc 
* Clean empty line 

### Default value changes

```diff
diff --git a/charts/helm-example/values.yaml b/charts/helm-example/values.yaml
index 306c1f8..280d3da 100644
--- a/charts/helm-example/values.yaml
+++ b/charts/helm-example/values.yaml
@@ -1,19 +1,27 @@
 # Default values for mc1.
 # This is a YAML-formatted file.
 # Declare variables to be passed into your templates.
-
+## @param replicaCount [number, nullable] Description
 replicaCount: 1
-
+ ## @section image".
+ ## @param image.repository  image repository
+ ## @param image.pullPolicy image pullPolicy
+ ## @param image.tag image tag
 image:
   repository: example
   pullPolicy: IfNotPresent
   # Overrides the image tag whose default is the chart appVersion.
   tag: ""
-
+## @param imagePullSecrets Image registry secret names as an array
 imagePullSecrets: []
+## @param nameOverride Default name override
 nameOverride: ""
+## @param fullnameOverride Default full name override
 fullnameOverride: ""
-
+## @section serviceAccount".
+## @param serviceAccount.create  Enabled / Disabeld service acount
+## @param serviceAccount.annotations serviceAccount annotations
+## @param serviceAccount.name serviceAccount name
 serviceAccount:
   # Specifies whether a service account should be created
   create: true
@@ -22,12 +30,12 @@ serviceAccount:
   # The name of the service account to use.
   # If not set and create is true, a name is generated using the fullname template
   name: ""
-
+## @param podAnnotations podAnnotations
 podAnnotations: {}
-
+## @param podSecurityContext podSecurityContext
 podSecurityContext: {}
   # fsGroup: 2000
-
+## @param securityContext securityContext
 securityContext: {}
   # capabilities:
   #   drop:
@@ -35,27 +43,52 @@ securityContext: {}
   # readOnlyRootFilesystem: true
   # runAsNonRoot: true
   # runAsUser: 1000
-
+## @section service".
+## @param service.annotations service annotations
+## @param service.type  service type (ClusterIP , NodePort)
+## @param service.port service port
 service:
+  annotations: {}
   type: ClusterIP
   port: 80
-
+## @section ingress".
 ingress:
+  ## @param ingress.enabled Enable ingress record generation
   enabled: false
+  ## @param ingress.className IngressClass that will be be used to implement the Ingress (Kubernetes 1.18+)
   className: ""
+  ## @param ingress.annotations [object] Additional annotations for the Ingress resource. To enable certificate autogeneration, place here your cert-manager annotations.
+  ## Use this parameter to set the required annotations for cert-manager, see
+  ## ref: https://cert-manager.io/docs/usage/ingress/#supported-annotations
   annotations: {}
     # kubernetes.io/ingress.class: nginx
     # kubernetes.io/tls-acme: "true"
+  ## @param ingress.hosts[0].host
+  ## @param ingress.hosts[0].paths[0].path
+  ## @param ingress.hosts[0].paths[0].pathType
+  ## - host: chart-example.local
+  ##   paths:
+  ##    - path: /
+  ##      pathType: ImplementationSpecific
   hosts:
     - host: chart-example.local
       paths:
         - path: /
           pathType: ImplementationSpecific
+  ## @param ingress.tls TLS configuration for additional hostname(s) to be covered with this ingress record
+  ## ref: https://kubernetes.io/docs/concepts/services-networking/ingress/#tls
+  ## e.g:
+  ## tls:
+  ##  - secretName: chart-example-tls
+  ##    hosts:
+  ##     - chart-example.local
+  ##
   tls: []
   #  - secretName: chart-example-tls
   #    hosts:
   #      - chart-example.local
-
+ ## ref: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/
+ ## @param resources The resources limits/requests for the chart-example containers
 resources: {}
   # We usually recommend not to specify default resources and to leave this as a conscious
   # choice for the user. This also increases chances charts run on environments with little
@@ -67,16 +100,92 @@ resources: {}
   # requests:
   #   cpu: 100m
   #   memory: 128Mi
-
+## @section autoscaling".
+## @param autoscaling.enabled Enabled/Disabeld thew hpa
+## @param autoscaling.minReplicas Min number of replicas
+## @param autoscaling.maxReplicas Max number of replicas
+## @param autoscaling.targetCPUUtilizationPercentage The cpu metrcis that cause the scaleup
 autoscaling:
   enabled: false
   minReplicas: 1
   maxReplicas: 100
   targetCPUUtilizationPercentage: 80
   # targetMemoryUtilizationPercentage: 80
-
-nodeSelector: {}
-
-tolerations: []
-
-affinity: {}
+## nodeSelector:
+##   role: eks-cluster
+## nodeSelector: {}
+## tolerations:
+## - key: intention
+##   operator: Equal
+##   value: eks-cluster-mgt
+##   effect: NoSchedule
+## tolerations: []
+## affinity:
+##   podAntiAffinity:
+##     preferredDuringSchedulingIgnoredDuringExecution:
+##      - weight: 100
+##        podAffinityTerm:
+##          labelSelector:
+##            matchExpressions:
+##              - key: "component"
+##                operator: In
+##                values:
+##                - zookeeper
+##          topologyKey: "topology.kubernetes.io/zone"
+## affinity: {}
+## @section deployment
+## @param deployment.example.image.repository  image repository
+## @param deployment.example.image.pullPolicy image pullPolicy
+## @param deployment.example.image.tag image tag
+## @param deployment.example.envFroms[0].envFrom[0].configMapRef.name - the name of configmap or secretRef
+## deployment:
+##   api: (The deployment name)
+##     envFrom:
+##       - configMapRef:
+##           name: my-config
+##       - secretRef:
+##           name: my-secret
+##     env:
+##       - name: environment
+##         value: default
+##     image:
+##       repository: nginx
+##       pullPolicy: IfNotPresent
+##       # Overrides the image tag whose default is the chart appVersion.
+##       tag: ""
+deployment:
+  example:
+    image:
+      repository: example
+      pullPolicy: IfNotPresent
+      # Overrides the image tag whose default is the chart appVersion.
+      tag: ""
+    envFroms:
+      - envFrom:
+          - configMapRef:
+              name: example-service
+## @section cronjob Array of cronjob with name (e.g example )
+## @param cronjob.example.schedule the cron schedule
+## @param cronjob.example.successfulJobsHistoryLimit
+## @param cronjob.example.failedJobsHistoryLimit
+## @param cronjob.example.restartPolicy of cron job
+## @param cronjob.example.container.image
+## @param cronjob.example.container.command  array of commands
+## cronjob:
+##   example:
+##     schedule: */10 * * * *
+##     successfulJobsHistoryLimit: 1
+##     failedJobsHistoryLimit: 2
+##     restartPolicy: OnFailure
+##     container:
+##       image: busybox
+##       command: ["/bin/sh","-c","echo 'test'"]
+cronjob:
+  example:
+    schedule: "*/10 * * * *"
+    successfulJobsHistoryLimit: "1"
+    failedJobsHistoryLimit: "2"
+    restartPolicy: "OnFailure"
+    container:
+      image: busybox
+      command: ["/bin/sh", "-c", "echo 'test' "]
```

## 0.1.0 

**Release date:** 2024-01-18

![AppVersion: 1.16.0](https://img.shields.io/static/v1?label=AppVersion&message=1.16.0&color=success&logo=)
![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)


* Doun ver 

### Default value changes

```diff
# No changes in this release
```

## 0.1.1 

**Release date:** 2024-01-18

![AppVersion: 1.16.0](https://img.shields.io/static/v1?label=AppVersion&message=1.16.0&color=success&logo=)
![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)


* Bump version 
* Clean 

### Default value changes

```diff
# No changes in this release
```

## 0.1.0 

**Release date:** 2024-01-18

![AppVersion: 1.16.0](https://img.shields.io/static/v1?label=AppVersion&message=1.16.0&color=success&logo=)
![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)


* Rename example chart 

### Default value changes

```diff
# Default values for mc1.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: 1

image:
  repository: example
  pullPolicy: IfNotPresent
  # Overrides the image tag whose default is the chart appVersion.
  tag: ""

imagePullSecrets: []
nameOverride: ""
fullnameOverride: ""

serviceAccount:
  # Specifies whether a service account should be created
  create: true
  # Annotations to add to the service account
  annotations: {}
  # The name of the service account to use.
  # If not set and create is true, a name is generated using the fullname template
  name: ""

podAnnotations: {}

podSecurityContext: {}
  # fsGroup: 2000

securityContext: {}
  # capabilities:
  #   drop:
  #   - ALL
  # readOnlyRootFilesystem: true
  # runAsNonRoot: true
  # runAsUser: 1000

service:
  type: ClusterIP
  port: 80

ingress:
  enabled: false
  className: ""
  annotations: {}
    # kubernetes.io/ingress.class: nginx
    # kubernetes.io/tls-acme: "true"
  hosts:
    - host: chart-example.local
      paths:
        - path: /
          pathType: ImplementationSpecific
  tls: []
  #  - secretName: chart-example-tls
  #    hosts:
  #      - chart-example.local

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

autoscaling:
  enabled: false
  minReplicas: 1
  maxReplicas: 100
  targetCPUUtilizationPercentage: 80
  # targetMemoryUtilizationPercentage: 80

nodeSelector: {}

tolerations: []

affinity: {}
```

---
Autogenerated from Helm Chart and git history using [helm-changelog](https://github.com/mogensen/helm-changelog)
