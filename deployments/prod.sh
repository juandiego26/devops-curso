wget -O packer.zip https://releases.hashicorp.com/packer/1.2.1/packer_1.2.1_linux_amd64.zip?_ga=2.46879015.1437742939.1521475479-650164964.1521159473
unzip packer.zip
./packer validate deployments/template.json
./packer build deployments/template.json
