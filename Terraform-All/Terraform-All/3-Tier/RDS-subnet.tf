resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db-subnet-group"
  subnet_ids = [
    aws_subnet.db-private_subnet_az1.id,
    aws_subnet.db-private_subnet_az2.id,
  ]
}

resource "aws_db_instance" "mysql" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "admin"
  password             = "password"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot = true
  vpc_security_group_ids = [aws_security_group.db-sg.id]
  db_subnet_group_name  = aws_db_subnet_group.db_subnet_group.name
}