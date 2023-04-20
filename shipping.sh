script=$(realpath "0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
mysql_root_password=$1

echo -e "\e[36m>>>>>>installing maven<<<<<<<<\e[0m"
yum install maven -y

echo -e "\e[36m>>>>>>Adding application user<<<<<<<\e[0m"
useradd ${app_user}

echo -e "\e[36m>>>>>>creating DIRECTORY<<<<<<<<\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[36m>>>>>>downloading shipping file<<<<<<<<\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip

echo -e "\e[36m>>>>>>CHANGING TO APP DIRECTORY<<<<<<<<\e[0m"
cd /app

echo -e "\e[36m>>>>>>Extacting the shipping file<<<<<<<<\e[0m"
unzip /tmp/shipping.zip

echo -e "\e[36m>>>>>>cleaning maven package<<<<<<<<\e[0m"
mvn clean package

echo -e "\e[36m>>>>>>Cmoving file <<<<<<<<\e[0m"
mv target/shipping-1.0.jar shipping.jar

echo -e "\e[36m>>>>>>copying file<<<<<<<<\e[0m"
cp ${script_path}/shipping.service /etc/systemd/system/shipping.service


echo -e "\e[36m>>>>>>installing mysql<<<<<<<<\e[0m"
yum install mysql -y

echo -e "\e[36m>>>>>>calling the service<<<<<<<<\e[0m"
mysql -h mysql-dev.sujianilsrisriyaan.online -uroot -p${mysql_root_password} < /app/schema/shipping.sql
cp ${script_path}/shipping.service /etc/systemd/system/shipping.service

echo -e "\e[36m>>>>>>restarting the service<<<<<<<<\e[0m"
echo -e "\e[36m>>>>>>reloading the service<<<<<<<<\e[0m"
systemctl daemon-reload

echo -e "\e[36m>>>>>>starting and enabling service<<<<<<<<\e[0m"
systemctl enable shipping
systemctl restart shipping

