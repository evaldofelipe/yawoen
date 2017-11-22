variable "do_token" {}
variable "pub_key" {}
variable "pvt_key" {}
variable "ssh_fingerprint" {}
variable "private_range" {}

provider "digitalocean" {
  token = "${var.do_token}"
}
