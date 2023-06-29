variable "private_subnets_cidr" {
  description = "Private subnets cidr blocks"
  type = list
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnets_cidr" {
  description = "Public subnets cidr blocks"
  type = list
  default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

#azs {
#  description = "Avaliability zones"
#  type = list
#  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
#}

variable "region" {
  default = "us-east-1"
}
