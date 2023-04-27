terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket = "bucket-ayantola"
    key = "/bucket-ayantola/terraform.tfstate"
  }
}

#Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  credential = "~/.aws/config"
}
