
#Get availability zone
data "aws_availability_zones" "azs" {}

#VPC Modules:https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "jenkins_vpc"
  cidr = var.vpc_cidr

  azs            = data.aws_availability_zones.azs.names
  public_subnets = var.public_subnets

  enable_dns_hostnames    = true
  map_public_ip_on_launch = true

  tags = {
    name        = "jenkins_vpc"
    Terraform   = "true"
    environment = "Dev"
  }

  public_subnet_tags = {
    name = "jenkins_subnet"
  }
}


#Security Group Modules:https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/latest

module "security-group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "jenkins_sg"
  description = "Security group for jenkins server"
  vpc_id      = module.vpc.vpc_id
  #Inbound rules

  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      description = "Allow HTTP"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "Allow ssh"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  #Outbound rules
  egress_with_cidr_blocks = [
    {
      from_port  = 0
      to_port    = 0
      protocol   = "-1"
      cidr_block = "0.0.0.0/0"
    }
  ]

  tags = {
    name = "jenkins_sg"
  }
}


#ec2 module: https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest

module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "jenkins_server"

  instance_type               = var.instance_type
  ami                         = "ami-047126e50991d067b"
  key_name                    = "cloud-labs-nv"
  monitoring                  = true
  vpc_security_group_ids      = [module.security-group.security_group_id]
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  availability_zone           = data.aws_availability_zones.azs.names[0]
  user_data                   = file("user-data.sh")


  tags = {
    name        = "jenkins-server"
    Terraform   = "true"
    Environment = "dev"
  }
}
