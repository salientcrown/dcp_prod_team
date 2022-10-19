
terraform {
  required_version = ">=1.1.5"

  backend "s3" {
    bucket         = "silvercrossing"
    dynamodb_table = "terra"
    key            = "myenaj.tfstate"
    region         = "us-east-1"
    # encrypt        = "true"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"

}