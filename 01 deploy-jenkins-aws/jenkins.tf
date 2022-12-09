provider "aws" {}

resource "aws_instance" "jenkins-master" {
	ami                    = "ami-0d971d62e4d019dcc"
	instance_type          = "t2.micro"
	vpc_security_group_ids = [aws_security_group.jenkins-access.id]
	user_data              = file("install-jenkins.sh")
	key_name	       = "pair01"
}

resource "aws_security_group" "jenkins-access" {
	name = "Access to Jenkins by SSH and HTTPS"

	dynamic "ingress" {
		for_each = ["8080", "22"]		
		content {
			from_port   = ingress.value
	                to_port     = ingress.value
			protocol    = "tcp"
			cidr_blocks = ["0.0.0.0/0"]
			}
		}	
	

	egress {
                from_port   = 0
                to_port     = 0
                protocol    = "-1"
                cidr_blocks = ["0.0.0.0/0"]
                }
}

