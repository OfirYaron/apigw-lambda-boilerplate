provider "aws" {
  profile = var.aws_profile
}

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}