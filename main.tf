variable "server-name" {
type = string 
description = "Name of server to proviusion"
}

locals {
  minNumberServer =1
  maxNumberServer =10
}


output "out" {
  value = var.server-name
}

variable "number-of-servers" {
    type = number
    description = "requier number of servers"
  validation {
    condition = var.number-of-servers>=local.minNumberServer && var.number-of-servers<local.maxNumberServer
        error_message = "Not supported, it should be from the range [${local.minNumberServer},${local.maxNumberServer}]"
  }
}


