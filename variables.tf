variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"

  validation {
    condition     = can(cidrsubnet(var.cidr, 0, 0))
    error_message = "Must be valid IPv4 CIDR, e.g. 10.0.0.0/16."
  }
}

variable "subnets" {
  description = "List of subnet CIDR blocks"
  type        = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
   }

 


variable "public_ip_on_launch" {
  description = "Assign public IPs on launch"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}