terraform {
  backend "s3" {
    bucket         = "slopshack-terraform-us-east-1"
    key            = "dev/dns/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "Slopshack-Terraform-US-East-1-Locks"
    encrypt        = true
  }
}
