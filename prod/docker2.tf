resource "digitalocean_droplet" "docker2" {
    image = "docker-16-04"
    name = "docker2"
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
    ]
  }
}
