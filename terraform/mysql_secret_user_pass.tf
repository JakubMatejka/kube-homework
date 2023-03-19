resource "kubernetes_secret" "hw_mysql_user_password_secret" {
  metadata {
    name = "hw-mysql-user-pass"
    namespace = var.namespace
  }

  data = {
    password = var.mysql_user_password
  }

  type = "kubernetes.io/basic-auth"
}
