output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "subnet_ids" {
  value = aws_subnet.private_subnet[*].id
}

output "route_table_ids" {
  value = [aws_route_table.private_route_table.id]
}
