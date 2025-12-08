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

# Inupt - Bucket prefix jako zmienna + jako domyślny jest ustawiony Twój
variable "bucket_prefix" {
  description = "Prefiks dla nazwy bucketu"
  type        = string
  default     = "awsninja7-"
}

# Inupt - Tagi, gdzie domyślne jest w variable "puropse": "learning" (moze być nadpisany)
variable "purpose" {
  description = "Cel użycia"
  type        = string
  default     = "learning"  # Domyślne
}

 resource "aws_s3_bucket" "my_bucket" {
    bucket_prefix = var.bucket_prefix
      tags = {
    owner   = "so"
    purpose = var.purpose  
  }
 }

 output "bucket-name" {
   value = aws_s3_bucket.my_bucket.bucket
 }


resource "aws_s3_object" "object" {
for_each = toset(["plik","plik2"])

  bucket = aws_s3_bucket.my_bucket.bucket
  key    = "${each.key}"
  source = ".terraform/test/${each.key}" 
#content = ""

}