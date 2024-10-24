/*Variables declaration file
Parameters refer to "terraform.tfvars"*/

variable "vpc_cidr" {
  description = "jenkins_VPC CIDR declaration"
  type        = string
}

variable "public_subnets" {
  description = "public subnet CIDR"
  type        = list(string)
}

variable "instance_type" {
  description = "Instance Type"
  type        = string
}