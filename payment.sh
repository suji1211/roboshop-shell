script=$(realpath "0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
rabbitmq_appuser_password=$1

if [ -z "mysql_root_password" ]; then
  echo Input MySQL Root password Missing
  exit
fi

component=payment
func_python