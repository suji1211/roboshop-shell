script=$(realpath "0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

func_print_head() {
  echo -e "\e[36m>>>>>>>>> $1 <<<<<<<<<<\e[0m"
}

func_print_head "mongo config file"
cp mongo.repo /etc/yum.repos.d/mongo.repo

func_print_head "installing mongo file"
yum install mongodb-org -y

func_print_head "changing 127.0.0.1 to 0.0.0.0"
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/mongod.conf

func_print_head "restarting mongo file"
systemctl enable mongod
systemctl start mongod

#edit the file replace 127.0.0.1 with 0.0.0.0