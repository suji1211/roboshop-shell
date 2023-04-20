script=$(realpath "0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
mysql_root_password=$1

func_print_head "installing maven"
yum install maven -y

func_print_head "Adding application user"
useradd ${app_user}

func_print_head "creating DIRECTORY"
rm -rf /app
mkdir /app

func_print_head "downloading shipping file"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip

func_print_head "CHANGING TO APP DIRECTORY"
cd /app

func_print_head "Extacting the shipping file"
unzip /tmp/shipping.zip

func_print_head "cleaning maven package"
mvn clean package

func_print_head "moving file"
mv target/shipping-1.0.jar shipping.jar

func_print_head "copying file"
cp ${script_path}/shipping.service /etc/systemd/system/shipping.service


func_print_head "installing mysql"
yum install mysql -y

func_print_head "calling the service"
mysql -h mysql-dev.sujianilsrisriyaan.online -uroot -p${mysql_root_password} < /app/schema/shipping.sql
cp ${script_path}/shipping.service /etc/systemd/system/shipping.service


func_print_head "reloading the service"
systemctl daemon-reload

func_print_head "restarting the service"
systemctl enable shipping
systemctl restart shipping

