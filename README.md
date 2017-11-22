# Automate something

This automation helps you to automate something.
That's help a lot!

**To install terraform**

On mac
```bash
brew install terraform
```
On linux/unix
```bash
wget https://releases.hashicorp.com/terraform/0.11.0/terraform_0.11.0_linux_amd64.zip 
unzip terraform_0.11.0_linux_amd64.zip
mv terraform /usr/local/bin 
```

**Terraforms vars**

On project directory, copy a file where go the sensitive information about cloud provider, and put your information

```bash
cp watcher/terraform.tfvars.example watcher/terraform.tfvars
```

You can generate the Digital Ocean API here:
https://cloud.digitalocean.com/settings/api/tokens

You need create a decrypted copy of your sshkey to work on this project.
```bash
openssl rsa -in ~/.ssh/id_rsa -out ~/.ssh/id_rsa_terraform
```
To get a fingerprint of your sshkey
```bash
ssh-keygen -E md5 -lf ~/.ssh/id_rsa.pub | awk '{print $2}'
```
NOTE: Use the same key as you using on Digital Ocean to control the new environment.


Install terraform dependencies
```bash
cd watcher/ && terraform init
```
Start deploy proccess
```bash
terraform plan
terraform apply
```
The last output is a watcher IP. Access to configurate the sensitive information to prod environment.
