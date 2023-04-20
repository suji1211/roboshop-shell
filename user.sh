script=$(realpath "0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
echo -e "\e[36m>>>>>> downloading nodejs<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

component=user

func_nodejs

echo -e "\e[36m>>>>>>coping mongo repo<<<<<<<<\e[0m"
cp {script_path}/mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[36m>>>>>> installing mongo<<<<<<<<\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[36m>>>>>> loading schema<<<<<<<<\e[0m"
mongo --host mongodb-dev.sujianilsrisriyaan.online </app/schema/user.js