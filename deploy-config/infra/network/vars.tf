variable "aws_region" {
  description = "The AWS region to deploy to"
  type        = string
}

variable "app_name" {
  description = "The name of application"
  type        = string
}

variable "env" {
    description = "The name of environment"
    type        = string
}
