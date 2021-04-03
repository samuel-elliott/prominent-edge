terraform {
  required_version = "~> 0.14.9"
  required_providers {
    aws = "~> 3.35.0"
  }
}
provider "aws" {
  region = "us-east-1"
  # Update this to point to your own AWS credentials as need be.
  shared_credentials_file = "~/.aws/credentials"
}
