resource "kubernetes_manifest" "hw_mysql_deployment" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "labels" = {
        "app" = "hw-mysql"
      }
      "name" = "hw-mysql"
      "namespace" = var.namespace
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "app" = "hw-mysql"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "hw-mysql"
          }
        }
        "spec" = {
          "containers" = [
            {
              "env" = [
                {
                  "name" = "MYSQL_ROOT_PASSWORD"
                  "valueFrom" = {
                    "secretKeyRef" = {
                      "key" = "password"
                      "name" = "hw-mysql-root-pass"
                    }
                  }
                },
                {
                  "name" = "MYSQL_DATABASE"
                  "value" = "wp_db"
                },
                {
                  "name" = "MYSQL_USER"
                  "value" = "wp_user"
                },
                {
                  "name" = "MYSQL_PASSWORD"
                  "valueFrom" = {
                    "secretKeyRef" = {
                      "key" = "password"
                      "name" = "hw-mysql-user-pass"
                    }
                  }
                },
              ]
              "image" = format("%s:%s",var.mysql_image_name, var.mysql_image_tag)
              "livenessProbe" = {
                "exec" = {
                  "command" = [
                    "mysqladmin",
                    "-uroot",
                    "-p$MYSQL_ROOT_PASSWORD",
                    "ping",
                  ]
                }
                "initialDelaySeconds" = 60
                "periodSeconds" = 10
                "timeoutSeconds" = 5
              }
              "name" = "mysql"
              "ports" = [
                {
                  "containerPort" = 3306
                  "name" = "mysql"
                },
              ]
              "readinessProbe" = {
                "exec" = {
                  "command" = [
                    "mysqladmin",
                    "-uroot",
                    "-p$MYSQL_ROOT_PASSWORD",
                    "ping",
                  ]
                }
                "initialDelaySeconds" = 60
                "periodSeconds" = 10
                "timeoutSeconds" = 5
              }
              "resources" = {
                "limits" = {
                  "cpu" = "2"
                  "memory" = "1Gi"
                }
                "requests" = {
                  "cpu" = "1"
                  "memory" = "512Mi"
                }
              }
              "volumeMounts" = [
                {
                  "mountPath" = "/var/lib/mysql"
                  "name" = "hw-mysql-storage"
                },
              ]
            },
          ]
          "volumes" = [
            {
              "name" = "hw-mysql-storage"
              "persistentVolumeClaim" = {
                "claimName" = "hw-mysql-pvc"
              }
            },
          ]
        }
      }
    }
  }
}
