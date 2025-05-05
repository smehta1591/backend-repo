terraform {

  required_providers {

    aws = {

      source  = "hashicorp/aws"

      version = "~> 4.0"

    }

  }

}
 
provider "aws" {

  region = "us-east-1"

}

resource "aws_s3_bucket" "example" {
  bucket = "mehtashreyaresume-website.com"
}
 
resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.example.id


redirect_all_requests_to {
       host_name = "www.mehtashreyaresume-website.com"
       protocol = "https"

}
}



 