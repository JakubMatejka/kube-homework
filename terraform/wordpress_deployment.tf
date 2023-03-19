resource "kubernetes_manifest" "hw_wordpress_deployment" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "labels" = {
        "app" = "hw-wordpress"
      }
      "name" = "hw-wordpress"
      "namespace" = var.namespace
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "app" = "hw-wordpress"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "hw-wordpress"
          }
        }
        "spec" = {
          "containers" = [
            {
              "env" = [
                {
                  "name" = "WORDPRESS_DATABASE_HOST"
                  "value" = "hw-mysql-service"
                },
                {
                  "name" = "WORDPRESS_DATABASE_NAME"
                  "value" = "wp_db"
                },
                {
                  "name" = "WORDPRESS_DATABASE_USER"
                  "value" = "wp_user"
                },
                {
                  "name" = "WORDPRESS_DATABASE_PASSWORD"
                  "valueFrom" = {
                    "secretKeyRef" = {
                      "key" = "password"
                      "name" = "hw-mysql-user-pass"
                    }
                  }
                },
                {
                  "name" = "WORDPRESS_HTACCESS_OVERRIDE_NONE"
                  "value" = "no"
                },
                {
                  "name" = "WORDPRESS_ENABLE_HTACCESS_PERSISTENCE"
                  "value" = "no"
                },
                {
                  "name" = "WORDPRESS_BLOG_NAME"
                  "value" = "Sample Blog"
                },
                {
                  "name" = "WORDPRESS_SKIP_BOOTSTRAP"
                  "value" = "no"
                },
                {
                  "name" = "WORDPRESS_SCHEME"
                  "value" = "http"
                },
                {
                  "name" = "APACHE_HTTP_PORT_NUMBER"
                  "value" = "8080"
                },
              ]
              "image" = format("%s:%s",var.wordpress_image_name, var.wordpress_image_tag)
              "livenessProbe" = {
                "failureThreshold" = 3
                "httpGet" = {
                  "path" = "/wp-json/wp/v2"
                  "port" = "http"
                  "scheme" = "HTTP"
                }
                "initialDelaySeconds" = 60
                "periodSeconds" = 10
                "successThreshold" = 1
                "timeoutSeconds" = 10
              }
              "name" = "wordpress"
              "ports" = [
                {
                  "containerPort" = 8080
                  "name" = "http"
                  "protocol" = "TCP"
                },
              ]
              "readinessProbe" = {
                "failureThreshold" = 3
                "httpGet" = {
                  "path" = "/wp-json/wp/v2"
                  "port" = "http"
                  "scheme" = "HTTP"
                }
                "initialDelaySeconds" = 60
                "periodSeconds" = 10
                "successThreshold" = 1
                "timeoutSeconds" = 10
              }
              "resources" = {
                "limits" = {
                  "cpu" = "500m"
                  "memory" = "512Mi"
                }
                "requests" = {
                  "cpu" = "250m"
                  "memory" = "256Mi"
                }
              }
              "volumeMounts" = [
                {
                  "mountPath" = "/bitnami/wordpress"
                  "name" = "hw-wordpress-storage"
                  "subPath" = "wordpress"
                },
              ]
            },
          ]
          "volumes" = [
            {
              "name" = "hw-wordpress-storage"
              "persistentVolumeClaim" = {
                "claimName" = "hw-wordpress-pvc"
              }
            },
          ]
        }
      }
    }
  }
}
