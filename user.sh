script=$(realpath "0")
script_path=$(dirname "$script")
source ${script_path}/common.sh


if [ -z "mysql_root_password" ]; then
  echo Input MySQL Root password Missing
  exit
fi

component=user
schema_setup=mongo
func_nodejs

