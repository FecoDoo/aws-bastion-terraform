sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install terraform

echo "\nSuccessfully installed Terraform.\n"

sudo dnf install helm

echo "\nSuccessfully installed Helm.\n"