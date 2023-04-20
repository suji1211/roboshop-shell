script=$(realpath "0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
component=user

func_print_head() {
  echo -e "\e[36m>>>>>>>>> $1 <<<<<<<<<<\e[0m"
}

func_print_head  "downloading nodejs"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

func_nodejs

func_print_head "coping mongo repo"
cp {script_path}/mongo.repo /etc/yum.repos.d/mongo.repo

func_print_head  "installing mongo"
yum install mongodb-org-shell -y

func_print_head  "loading schema"
mongo --host mongodb-dev.sujianilsrisriyaan.online </app/schema/user.js