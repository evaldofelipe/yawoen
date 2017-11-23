resource "digitalocean_droplet" "docker1" {
    image = "docker-16-04"
    name = "docker1"
    region = "nyc3"
    size = "512mb"
    private_networking = true
    ssh_keys = [
      "${var.ssh_fingerprint}"
    ]

  connection {
      user = "root"
      type = "ssh"
      private_key = "${file(var.pvt_key)}"
      timeout = "2m"
  }

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "docker run -d -p 80:8000  -t jwilder/whoami",
      "iptables -A INPUT -p tcp -s ${var.private_range} --dport 22 -j ACCEPT",
      "iptables -A INPUT -p udp -s ${var.private_range} --dport 53 -j ACCEPT",
      "iptables -A INPUT -p tcp -s ${var.private_range} --dport 53 -j ACCEPT",
      "iptables -A INPUT -p tcp -s 0.0.0.0/0 --dport 22 -j DROP",
      "iptables -A INPUT -p udp -s 0.0.0.0/0 --dport 53 -j DROP",
      "iptables -A INPUT -p tcp -s 0.0.0.0/0 --dport 53 -j DROP", 
    ]
  }
}
output "ip-docker1" {
  value = "Docker1 address: ${digitalocean_droplet.docker1.ipv4_address}"
}
