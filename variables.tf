variable "aws_profile" {
  default = "default"
}

variable "lambda_name" {
  default = "lambda_name"
}

variable "lambda_description" {
  default = "My awesome lambda function"
}

variable "apigw_name" {
  default = "my_endpoints"
}

variable "apigw_stage_name" {
  default = "production"
}