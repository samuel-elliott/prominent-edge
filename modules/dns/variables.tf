#Specifies the AWS region to use.
variable "aws_region" {
    description = "Specifies the AWS region, both for deployment and tagging purposes."
    type = string
}

# For passing the ALB's DNS name to set the accompanying alias record.
#variable "load_balancer_dns_name" {
#    description = "Variable for passing the ALB's DNS name from the network module."
#    type = string
#}

# For passing the ALB's zone id to set the accompanying alias record.
#variable "load_balancer_zone_id" {
#    description = "Variable for passing the ALB's Zone ID record from the network module."
#    type = string
#}
