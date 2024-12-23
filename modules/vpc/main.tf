// ---
// Create the VPC
// ---
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = var.name
  }
}

// ---
// Create the Public Subnets
// ---
resource "aws_subnet" "public_subnet" {
  count                   = length(var.availability_zones)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.name}-public-subnet-${count.index}"
  }
}

// ---
// Create the Private Subnets
// ---
resource "aws_subnet" "private_subnet" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = "${var.name}-private-subnet-${count.index}"
  }
}

// ---
// Create the Internet Gateway
// ---
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.name}-igw"
  }
}

// ---
// Create the NAT Gateway
// ---
resource "aws_eip" "nat_eip" {
  tags = {
    Name = "${var.name}-nat-eip"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet[0].id
  tags = {
    Name = "${var.name}-nat-gateway"
  }
}

// Public Route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.name}-public-route-table"
  }
}

resource "aws_route_table_association" "public_route_association" {
  count          = length(aws_subnet.public_subnet[*].id)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

// Private Route Table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "${var.name}-private-route-table"
  }
}

resource "aws_route_table_association" "private_route_association" {
  count          = length(aws_subnet.private_subnet[*].id)
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}

# // ---
# // Create an Auto Scaling Group
# // ---
# resource "aws_autoscaling_group" "asg" {
#   launch_template {
#     id      = aws_launch_template.launch_template.id
#     version = "$Latest"
#   }

#   vpc_zone_identifier = aws_subnet.private_subnet[*].id

#   min_size         = var.asg_min_size // Minimum number of instances (e.g., 1)
#   max_size         = var.asg_max_size // Maximum number of instances (e.g., 5)
#   desired_capacity = var.asg_desired_capacity // Desired number of instances (e.g., 2)

#   health_check_type         = "EC2"
#   health_check_grace_period = 300

#   tags = [
#     {
#       key                 = "Name"
#       value               = "${var.name}-asg-instance"
#       propagate_at_launch = true
#     }
#   ]

#   lifecycle {
#     create_before_destroy = true
#   }
# }
