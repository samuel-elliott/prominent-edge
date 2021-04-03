#Specifies the AWS region to use.
variable "aws_region" {
    description = "Specifies the AWS region, both for deployment and tagging purposes."
    type = string
}

variable "aws_caller_identity" {
    description = "Specifies the Account ID being invoked by Terraform to interact with AWS."
    type = string
}

variable "domain" {
    description = "The name of the domain being created within Elasticserach."
    type = string
}

#variable "ssl_certificate" {
#    description = "The SSL certificate to be used on the listener of the ALB"
#    type = string
#}

# The VPC being worked with
#variable "vpc-id" {
#    description = "Name of the VPC"
#    type = string
#}

# The number of AZs you want to deploy.
variable "az_count" {
  description = "Number of AZs you want to deploy in the region in question"
  type = number
}
