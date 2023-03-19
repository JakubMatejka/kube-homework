resource "kubernetes_namespace" "namespace_homework" {
  metadata {
    name = "homework"
  }
}
