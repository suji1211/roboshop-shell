script=$(realpath "0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

func_print_head() {
  echo -e "\e[36m>>>>>>>>> $1 <<<<<<<<<<\e[0m"
}

func_print_head "Downloading nodejs file"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

component=catalogue

func_nodejs

func_print_head "Mongo config file"
cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo

func_print_head "Installing Mongodb file"
yum install mongodb-org-shell -y

func_print_head "executing mongo file"
mongo --host mongodb-dev.sujianilsrisriyaan.online </app/schema/catalogue.js