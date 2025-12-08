terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.25.0"
    }
  }
}
 
provider "aws" {
  # Configuration options
}
data "aws_region" "current" {}

# Inupt - Bucket prefix jako zmienna + jako domyślny jest ustawiony Twój
variable "bucket_prefix" {
  description = "Prefiks dla nazwy bucketu"
  type        = string
  default     = "awsninja7-"
}

# Inupt - Tagi, gdzie domyślne jest w variable "puropse": "learning" (moze być nadpisany)
# Zawsze dodany tag do bucketu (lub wszędzie) "owner": "jw"
variable "purpose" {
  description = "Cel użycia"
  type        = string
  default     = "learning"  # Domyślne
}

locals {
  # Tag owner zawsze obecny - nie do nadpisania
  mandatory_tags = {
    owner = "so"
  }
  
  # Tagi nadpisywalne (purpose itp.)
  optional_tags =  {
    purpose = var.purpose
  }
}




 resource "aws_s3_bucket" "my_bucket" {
    bucket_prefix = var.bucket_prefix
#      tags = {
#    owner   = "so"
#    purpose = var.purpose  
#  }
tags = merge(local.mandatory_tags, local.optional_tags)
 }

 output "bucket-name" {
   value = aws_s3_bucket.my_bucket.bucket
 }

# Outputs: bucket ARN oraz pełny URL z HTTP
output "bucket_arn" {
  description = "ARN utworzonego bucketu"
  value       = aws_s3_bucket.my_bucket.arn
}

output "bucket_http_url" {
  description = "Pełny URL HTTP do bucketu"
  value       = "http://${aws_s3_bucket.my_bucket.bucket}.s3.${data.aws_region.current.name}.amazonaws.com"
  #http://awsninja7-20251208201944409100000001.s3-website-us-east-1.amazonaws.com
}

resource "aws_s3_object" "object" {
for_each = toset(["plik","plik2"])

  bucket = aws_s3_bucket.my_bucket.bucket
  key    = "${each.key}"
  source = ".terraform/test/${each.key}" 
#content = ""

}