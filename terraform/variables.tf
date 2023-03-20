variable "namespace" {
  type        = string
  description = "Kubernetes namespace"
  default     = "homework"
}

variable "mysql_image_name" {
  type        = string
  description = "MySQL image name"
  default     = "mysql"
}

variable "mysql_image_tag" {
  type        = string
  description = "MySQL image tag"
  default     = "8.0"
}

variable "wordpress_image_name" {
  type        = string
  description = "WordPress image name"
  default     = "docker.io/bitnami/wordpress"
}

variable "wordpress_image_tag" {
  type        = string
  description = "WordPress image tag"
  default     = "6.1.1"
}

variable "mysql_root_password" {
  type        = string
  description = "MySQL root password"
}

variable "mysql_user_password" {
  type        = string
  description = "MySQL user password"
}
