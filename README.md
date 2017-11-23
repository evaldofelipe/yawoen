# Automate docker app deploy

This example will help you to automate a docker enviroment, using terraform, on Digital Ocean.
That's help a lot!

## Install terraform

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
## Clone Repository
```bash
git clone https://github.com/evaldofelipe/yawoen
```

## Terraforms vars
On project directory, copy a file example where go the sensitive information about cloud provider.

```bash
cd yawoen && cp watcher/terraform.tfvars.example watcher/terraform.tfvars
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
Private IP's is only for administration access. You can add just a single IP or a entire range.

**NOTE:** Use the same key as you using on Digital Ocean to control the new environment.

## Deploy
Install terraform dependencies
```bash
cd watcher/ && terraform init
```
Start deploy proccess
```bash
terraform plan
terraform apply
```
**NOTE:** The deploy proccess can take a several time (20 minutes or more). 

**NOTE2:** This automated method is programed to deploy at 7AM and destroy the environment at 7PM.

## Testing
The last output is application address. To see the environment working:
```bash
curl APP_ADDRESS
```
## Monitoring
You can use the DigitalOcean panel to find information about RAM, CPU, WAN from your droplets.
https://cloud.digitalocean.com/droplets


