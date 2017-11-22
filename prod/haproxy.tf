resource "digitalocean_droplet" "haproxy" {
    image = "ubuntu-16-04-x64"
    name = "haproxy"
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
      # install haproxy 1.5
      "sudo add-apt-repository -y ppa:vbernat/haproxy-1.5",
      "sudo apt-get update",
      "sudo apt-get -y install haproxy",

      # download haproxy conf
      "sudo wget https://gist.githubusercontent.com/evaldofelipe/01f08e5a30857f41a7b0fd05a2ede695/raw/40ed6e637b4f1c9570ab7c85c3d834f02e75a129/haproxy -O /etc/haproxy/haproxy.cfg",

      # replace ip address variables in haproxy conf to use droplet ip addresses
      "sudo sed -i 's/HAPROXY_PUBLIC_IP/${digitalocean_droplet.haproxy.ipv4_address}/g' /etc/haproxy/haproxy.cfg",
      "sudo sed -i 's/DOCKER1_PRIVATE_IP/${digitalocean_droplet.docker1.ipv4_address_private}/g' /etc/haproxy/haproxy.cfg",
      "sudo sed -i 's/DOCKER2_PRIVATE_IP/${digitalocean_droplet.docker2.ipv4_address_private}/g' /etc/haproxy/haproxy.cfg",

      # restart haproxy to load changes
      "sudo service haproxy restart"
    ]
  }
}


