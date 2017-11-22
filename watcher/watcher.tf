resource "digitalocean_droplet" "watcher" {
    image = "ubuntu-14-04-x64"
    name = "watcher"
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
    	"apt-get update",
    	"apt-get install unzip git -y",
        "wget https://releases.hashicorp.com/terraform/0.11.0/terraform_0.11.0_linux_amd64.zip",
    	"unzip terraform_0.11.0_linux_amd64.zip",
    	"mv terraform /usr/local/bin",
        "rm -rf terraform_0.11.0_linux_amd64.zip",
        "git clone https://github.com/evaldofelipe/yawoen.git",
        "cd ~/yawoen/prod",
    	"terraform init && cp terraform.tfvars.example terraform.tfvars",
    ]
  }
 
  provisioner "file" {
    source      = "~/.ssh/id_rsa_terraform"
    destination = "~/.ssh/id_rsa_terraform"
    }

    provisioner "file" {
    source      = "~/.ssh/id_rsa.pub"
    destination = "~/.ssh/id_rsa.pub"
    }

    provisioner "file" {
    source      = "../watcher/terraform.tfvars"
    destination = "~/yawoen/prod/terraform.tfvars"
    }
  

    provisioner "remote-exec" {
    inline = [
        "cd ~/yawoen/prod",
        "terraform apply -auto-approve",
    ]
  }

}

output "ip" {
  value = "Done! watcher address: ${digitalocean_droplet.watcher.ipv4_address}"
}
