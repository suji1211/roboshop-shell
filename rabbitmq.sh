script=$(realpath "0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
rabbitmq_appuser_password=$1

func_print_head() {
  echo -e "\e[36m>>>>>>>>> $1 <<<<<<<<<<\e[0m"
}
func_print_head "downloading raberlang"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash

func_print_head "Installing erlang"
yum install erlang -y

func_print_head "downloading rabbitmq"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash

func_print_head "Installing rabbitmq"
yum install rabbitmq-server -y

func_print_head  "enabling rabbitmq server"
systemctl enable rabbitmq-server

func_print_head "restarting rabbitmq server"
systemctl start rabbitmq-server

func_print_head  "adding user"

rabbitmqctl add_user roboshop ${rabbitmq_appuser_password}

func_print_head "Setting permissions to user"
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"