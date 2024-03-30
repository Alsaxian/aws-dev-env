terraform {
  backend "s3" {
    bucket = "xitry-terraform-state"
    key    = "aws-dev-env/terraform.tfstate"
    region = "us-east-1"
  }
}