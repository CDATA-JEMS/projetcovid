variable "region_id" {
  description = "Region Irlande par défaut "
  default     = "eu-west-1"
}

variable "ami_id" {
  description = "ami version of ubuntu server 20.0"
  default     = "ami-022e8cc8f0d3c52fd"
}
variable "type_EC2" {
  default     = "m5.8xlarge" 
}

data "aws_vpc" "vpc_id" {
  default = true
}


