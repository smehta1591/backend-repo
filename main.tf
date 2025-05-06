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

terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket120"
    key            = "lambda/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}