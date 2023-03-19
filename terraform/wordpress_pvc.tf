resource "kubernetes_manifest" "hw_wordpress_pvc" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "PersistentVolumeClaim"
    "metadata" = {
      "labels" = {
        "app" = "hw-wordpress"
      }
      "name" = "hw-wordpress-pvc"
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
