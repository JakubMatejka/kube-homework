resource "kubernetes_manifest" "hw_wordpress_autoscale" {
  manifest = {
    "apiVersion" = "autoscaling/v2"
    "kind" = "HorizontalPodAutoscaler"
    "metadata" = {
      "name" = "hw-wordpress-autoscale"
      "namespace" = var.namespace
    }
    "spec" = {
      "maxReplicas" = 3
      "metrics" = [
        {
          "resource" = {
            "name" = "cpu"
            "target" = {
              "averageUtilization" = 50
              "type" = "Utilization"
            }
          }
          "type" = "Resource"
        },
      ]
      "minReplicas" = 1
      "scaleTargetRef" = {
        "apiVersion" = "apps/v1"
        "kind" = "Deployment"
        "name" = "hw-wordpress"
      }
    }
  }
}
