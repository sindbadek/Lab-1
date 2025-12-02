variable "server-name" {
type = string 
description = "Name of server to proviusion"
}

variable "list-of-names" {
  type = list (string)
}

locals {
  minNumberServer =1
  maxNumberServer =10
}


output "out" {
  value = "${var.server-name} x ${var.number-of-servers}"
}

variable "number-of-servers" {
    type = number
    description = "requier number of servers"
    default = 2
  validation {
    condition = var.number-of-servers>=local.minNumberServer && var.number-of-servers<local.maxNumberServer
        error_message = "Not supported, it should be from the range [${local.minNumberServer},${local.maxNumberServer}]"
  }
}


