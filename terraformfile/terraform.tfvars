/*variable parameters
New variables, declare at "variable.tf"*/
vpc_cidr       = "10.0.0.0/16"
public_subnets = ["10.0.1.0/24"]
instance_type  = "t2.medium"
ec2_image      = "ami-04b6019d38ea93034"