variable "image_id" {
  type    = string
  default = "ami-0502e817a62226e03"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_name" {
  type = string
  default = "ssh_key_desktop"
}