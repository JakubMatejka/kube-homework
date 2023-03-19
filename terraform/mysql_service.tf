resource "kubernetes_manifest" "hw_mysql_service" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "labels" = {
        "app" = "hw-mysql"
      }
      "name" = "hw-mysql-service"
      "namespace" = var.namespace
    }
    "spec" = {
      "ports" = [
        {
          "port" = 3306
        },
      ]
      "selector" = {
        "app" = "hw-mysql"
      }
      "type" = "ClusterIP"
    }
  }
}
