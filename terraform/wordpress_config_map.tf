resource "kubernetes_manifest" "hw_wordpress_config" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "ConfigMap"
    "metadata" = {
      "labels" = {
        "app" = "hw-wordpress"
      }
      "name" = "hw-wordpress-config"
      "namespace" = var.namespace
    }
    "data" = {
      "WORDPRESS_BLOG_NAME" = "Jakub's Blog"
      "WORDPRESS_ENABLE_HTACCESS_PERSISTENCE" = "no"
      "WORDPRESS_HTACCESS_OVERRIDE_NONE" = "no"
      "WORDPRESS_SKIP_BOOTSTRAP" = "no"
    }
  }
}
