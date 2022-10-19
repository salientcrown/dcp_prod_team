variable "env" {
  type    = string
  default = "DPC"
}

variable "aws_cidr" {
  type    = string
  default = "172.17.0.0/16"
}

variable "az_count" {
  description = "Number of AZs to cover in a given AWS region"
  default     = "2"
}

variable "key_pair" {
  default = "congo"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}