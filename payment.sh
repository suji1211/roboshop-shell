script=$(realpath "0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
rabbitmq_userapp_password=$1

if [ -z "$rabbitmq_userapp_password" ]; then
  echo Input roboshop appuser password Missing
  exit
fi

component=payment
func_python