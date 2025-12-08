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

variable "bucket_prefix" {
  description = "Prefiks dla nazwy bucketu"
  type        = string
  default     = "awsninja7-"
}
 
 resource "aws_s3_bucket" "my_bucket" {
    bucket_prefix = var.bucket_prefix
 }

 output "bucket-name" {
   value = aws_s3_bucket.my_bucket.bucket
 }


resource "aws_s3_object" "object" {
for_each = toset(["plik","plik2"])

  bucket = aws_s3_bucket.my_bucket.bucket
  key    = "${each.key}/"
source = null
content = ""

}