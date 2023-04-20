script=$(realpath "0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
echo -e "\e[36m>>>>>>>>> downloading nodejs file <<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

component=catalogue

func_nodejs

echo -e "\e[36m>>>>>>>>> mongo config file <<<<<<\e[0m"
cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[36m>>>>>>>>> installing file <<<<<<\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[36m>>>>>>>>> mexecuting mongo file <<<<<<\e[0m"
mongo --host mongodb-dev.sujianilsrisriyaan.online </app/schema/catalogue.js