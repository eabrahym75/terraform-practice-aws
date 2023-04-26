terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  # backend "s3" {
  #   bucket = "bucket-eabrahym"
  #   key    = "aws/bucket-eabrahym/terraform.tfstate"
  #   region = "us-east-1"
  #
  # }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}
