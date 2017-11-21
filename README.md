#Automate something

This automation helps you to automate something.
That's help a lot!

to install terraform

on mac
```bash
brew install terraform
```
on linux/unix
```bash
wget https://releases.hashicorp.com/terraform/0.11.0/terraform_0.11.0_linux_amd64.zip 
unzip terraform_0.11.0_linux_amd64.zip
mv terraform /usr/local/bin 
```

On project directory, copy a file where go the sensitive information about cloud provider, and put your information

```bash
cp watcher/terraform.tfvars.example watcher/terraform.tfvars
```

install terraform dependencies
```bash
cd watcher/ && terraform init
```
