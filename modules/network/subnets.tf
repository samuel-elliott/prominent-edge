# Fetch AZs in the current region
data "aws_availability_zones" "available" {
}

# Create var.az_count private subnets, each in a different AZ
resource "aws_subnet" "private" {
  count             = var.az_count
  cidr_block        = cidrsubnet(aws_vpc.Sam-Elliott-test.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_id            = aws_vpc.Sam-Elliott-test.id

  tags = {
    Name = "Sam Elliott test - Development Environment - Private Subnet"
    Region = var.aws_region
    Environment = var.environment
  }
}

# Create var.az_count public subnets, each in a different AZ
resource "aws_subnet" "public" {
  count                   = var.az_count
  cidr_block              = cidrsubnet(aws_vpc.Sam-Elliott-test.cidr_block, 8, var.az_count + count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  vpc_id                  = aws_vpc.Sam-Elliott-test.id
  map_public_ip_on_launch = true

  tags = {
    name = "Sam Elliott test - Development Environment - Public Subnet"
    Region = var.aws_region
    Environment = var.environment
  }
}

# Internet Gateway for the public subnet.
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.Sam-Elliott-test.id

  tags = {
    Name = "Sam Elliott test - Development Environment - Internet Gateway"
    Region = var.aws_region
    Environment = var.environment
  }
}

# Route public subnet traffic through the Internet Gateway.
resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.Sam-Elliott-test.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

# Create two Elastic IPs for two separate NAT gateways.
resource "aws_eip" "gw" {
  count      = var.az_count
  vpc        = true
  depends_on = [aws_internet_gateway.gw]

  tags = {
    Name = "Sam Elliott test - Development Environment - Elastic IP Address"
    Region =var.aws_region
    Environment = var.environment
  }
}

# Create two NAT gateways, one for each public subnet.
resource "aws_nat_gateway" "gw" {
  count         = var.az_count
  subnet_id     = element(aws_subnet.public[*].id, count.index)
  allocation_id = element(aws_eip.gw[*].id, count.index)
#  allocation_id = element(aws_eip.gw[*].id, 0)  # ORIGINAL, results in first EIP being allocated a second time and second NAT Gateway fails.

  tags = {
    Name = "Sam Elliott test - Development Environment - NAT Gateway"
    Region = var.aws_region
    Environment = var.environment
  }
}

# Create a new route table for the private subnets, make it route non-local traffic through the NAT gateway to the internet
resource "aws_route_table" "private" {
  count  = var.az_count
  vpc_id = aws_vpc.Sam-Elliott-test.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.gw[*].id, count.index)
  }

  tags = {
    Name = "Sam Elliott test - Development Environment - Private Subnet Route Table"
    Region = var.aws_region
    Environment = var.environment
  }
}

# Explicitly associate the newly created route tables to the private subnets (so they don't default to the main route table)
resource "aws_route_table_association" "private" {
  count          = var.az_count
  subnet_id      = element(aws_subnet.private[*].id, count.index)
  route_table_id = element(aws_route_table.private[*].id, count.index)
}
