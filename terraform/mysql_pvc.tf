resource "kubernetes_manifest" "hw_mysql_pvc" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "PersistentVolumeClaim"
    "metadata" = {
      "labels" = {
        "app" = "hw-mysql"
      }
      "name" = "hw-mysql-pvc"
      "namespace" = var.namespace
    }
    "spec" = {
      "accessModes" = [
        "ReadWriteOnce",
      ]
      "resources" = {
        "requests" = {
          "storage" = "5Gi"
        }
      }
    }
  }
}
