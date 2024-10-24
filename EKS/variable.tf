/*Variables declaration file
Parameters refer to "terraform.tfvars"*/

variable "vpc_cidr" {
  description = "VPC CIDR for EKS vpc"
  type        = string
}

variable "public_subnets" {
  description = "public subnet CIDR for EKS vpc"
  type        = list(string)
}

variable "private_subnets" {
  description = "private subnet CIDR for EKS vpc"
  type        = list(string)
}

variable "instance_types" {
  description = "Node Instances"
  type        = list(string)
}