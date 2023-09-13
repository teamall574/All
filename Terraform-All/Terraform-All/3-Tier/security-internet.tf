resource "aws_security_group" "internet-load" {
  name        = "internet-load"
  description = "Allow all inbound traffic"
  vpc_id      = "${aws_vpc.main.id}"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    }
}

##this if for web-app to connect the server alos open the port

resource "aws_security_group" "web-load" {
  name        = "web-load"
  description = "Allow all inbound traffic"
  vpc_id      = "${aws_vpc.main.id}"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    }
}

//Internal security group 

resource "aws_security_group" "internal_sg" {
  name_prefix = "internal-sg-"
  
  // Allow incoming traffic from the anji security group
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    security_groups = [aws_security_group.web-load.id]
  }
  
  // Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

//private security group

resource "aws_security_group" "private-sg" {
  name_prefix = "private-sg"
  
  // Allow incoming traffic from the anji security group
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.internal_sg.id]
  }
  
  // Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

//db-security-group

resource "aws_security_group" "db-sg" {
  name_prefix = "private-sg"
  
  // Allow incoming traffic from the anji security group
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.private-sg.id]
  }
  
  // Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



