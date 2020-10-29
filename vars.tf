variable "AWS_REGION" {
  default = "us-east-1"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

variable "certificate_arn" {
  default = "YOUR_CERTIFICATE_ARN"
}

variable "route53_hosted_zone_name" {
  default = "YOUR_HOSTED_ZONE_NAME"
}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-0947d2ba12ee1ff75"
    us-west-2 = "ami-06b94666"
    eu-west-1 = "ami-844e0bf7"
  }
}
