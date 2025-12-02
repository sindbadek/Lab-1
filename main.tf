variable "server-name" {
type = string 
description = "Name of server to proviusion"
}


output "out" {
  value = var.server-name
}