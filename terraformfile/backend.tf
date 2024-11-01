terraform {
  backend "s3" {
    bucket = "terraformstatebucket22oct"
    key    = "jenkins/terraform.tf"
    region = "ap-southeast-1"
  }
}