#Specifies the AWS region to use.
variable "aws_region" {
    description = "Specifies the AWS region, both for deployment and tagging purposes."
    type = string
}

# The number of AZs you want to deploy.
variable "az_count" {
  description = "Number of AZs you want to deploy in the region in question"
  type = number
}

# The name of the environment you want to deploy.
variable "environment_name" {
    description = "Name to use for further dileneation of environment naming"
    type = string
}

# Environment variable for tagging purposes.
variable "environment" {
    description = "Variable to set for tagging the environment you want to deploy."
    type = string
}

variable "ssl_certificate" {
    description = "The SSL certificate to be used on the listener of the ALB"
    type = string
}

variable "health_check_path" {
  description = "The path for the ALB to check to determine an instance's health."
  type = string
}

variable "app_port" {
  description = "Port exposed by the docker image to accept traffic to. Default is 443"
  type = number
}
