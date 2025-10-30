terraform {
  required_providers {
    aws ={
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}

provider "aws" {
    region = "us-east-1"
}

resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "key" {
  key_name = "nueva_clave"
  public_key = tls_private_key.key.public_key_openssh
}

resource "local_file" "private_key" {
  content = tls_private_key.key.private_key_pem
  filename = "${path.module}/nueva_clave.pem"
  file_permission = "0600"
}

resource "aws_s3_bucket" "mi_s3" {
  bucket ="mi-bucket-gabriel-2"

}