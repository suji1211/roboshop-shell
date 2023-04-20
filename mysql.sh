script=$(realpath "0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

if [ -z "mysql_root_password" ]; then
  echo Input MySQL Root password Missing
  exit
fi

func_print_head() {
  echo -e "\e[36m>>>>>>>>> $1 <<<<<<<<<<\e[0m"
}

func_print_head "disabling the mysql"
dnf module disable mysql -y

func_print_head "copying mysql repo file"
cp ${script_path}/mysql.repo /etc/yum.repos.d/mysql.repo

func_print_head "Installing mysql server"
yum install mysql-community-server -y

func_print_head  "Enabling my sql"
systemctl enable mysqld

func_print_head "starting the service"
systemctl restart mysqld

func_print_head "resetting mysql password"
mysql_secure_installation --set-root-pass $mysql_root_password