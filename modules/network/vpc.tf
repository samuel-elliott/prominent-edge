# Create the VPC. This is kind of important.
resource "aws_vpc" "Sam-Elliott-test" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Sam Elliott Elasticsearch test - Development Environment - VPC"
    Region = var.aws_region
    Environment = var.environment
  }
}
