provider "aws" {
#ini adalah region
  region = "ap-southeast-1"

}

data "aws_region" "current" {
}

data "aws_availability_zones" "available" {
}

provider "http" {
}

