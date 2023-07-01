resource "aws_db_subnet_group" "rds-subnet-group" {
  name       = "rds-subnet-group"
  subnet_ids = [
    module.vpc.private_subnets[0],
    module.vpc.private_subnets[1]
  ]
}

resource "aws_security_group" "rds-sg" {
  name        = "rds-sg"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = [module.vpc.private_subnets_cidr_blocks[0], module.vpc.private_subnets_cidr_blocks[1], module.vpc.private_subnets_cidr_blocks[2]]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg"
  }
}

resource "aws_db_instance" "database" {
  allocated_storage    = 10
  engine               = "mysql"
  instance_class       = "db.t3.micro"
  db_name              = var.db_name
  username             = var.db_user
  password             = var.db_password
  db_subnet_group_name = aws_db_subnet_group.rds-subnet-group.name
  vpc_security_group_ids = [aws_security_group.rds-sg.id]
  skip_final_snapshot  = true

  lifecycle {
    create_before_destroy = true
  }
}
