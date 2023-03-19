resource "kubernetes_secret" "hw_mysql_root_password_secret" {
  metadata {
    name = "hw-mysql-root-pass"
    namespace = var.namespace
  }

  data = {
    password = var.mysql_root_password
  }

  type = "kubernetes.io/basic-auth"
}
