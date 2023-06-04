
# Configure the provider software version
terraform {
  backend "s3" {
    encrypt = true    
    bucket = "backendtf-state-bucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "dynamodb-state-lock"
  }
}
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}