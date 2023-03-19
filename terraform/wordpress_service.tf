resource "kubernetes_manifest" "hw_wordpress_service" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "labels" = {
        "app" = "hw-wordpress"
      }
      "name" = "hw-wordpress-service"
      "namespace" = var.namespace
    }
    "spec" = {
      "ports" = [
        {
          "name" = "http"
          "port" = 8080
          "protocol" = "TCP"
          "targetPort" = 8080
        },
      ]
      "selector" = {
        "app" = "hw-wordpress"
      }
      "type" = "LoadBalancer"
    }
  }
}
