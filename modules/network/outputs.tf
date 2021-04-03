output "vpc-id" {
  value = aws_vpc.Sam-Elliott-test.id
}

output "subnets_private-id" {
  value = aws_subnet.private[*].id
}

output "subnets_private-arn" {
  value = aws_subnet.private[*].arn
}
