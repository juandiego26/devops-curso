wget -O /tmp/packer.zip https://releases.hashicorp.com/packer/1.2.1/packer_1.2.1_linux_amd64.zip?_ga=2.46879015.1437742939.1521475479-650164964.1521159473
wget -O /tmp/terraform.zip https://releases.hashicorp.com/terraform/0.11.4/terraform_0.11.4_linux_amd64.zip?_ga=2.166740030.1883617524.1521468662-1195488747.1521202943
unzip /tmp/packer.zip -d ~/bin
unzip /tmp/terraform.zip -d ~/bin
packer validate deployments/template.json &&  
packer build deployments/template.json &&
export TF_VAR_image_id=$(curl -H "Authorization: Bearer $DIGITALOCEAN_API_TOKEN" "https://api.digitalocean.com/v2/images?private=true" | jq ."images[] | select(.name == \"platzi-demo-snapshot-$CIRCLE_BUILD_NUM\") | .id")
echo $TF_VAR_image_id
cd infra && terraform apply && cd .. &&
git add infra && git commit -m "Deployed $CIRCLE_BUILD_NUM [skip ci]" &&
git push origin master
