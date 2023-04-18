echo -e "\e[36m>>>>>>installing maven<<<<<<<<\e[0m"
yum install maven -y

echo -e "\e[36m>>>>>>Adding application user<<<<<<<\e[0m"
useradd roboshop

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
cp /home/centos/roboshop-shell/shipping.service /etc/systemd/system/shipping.service


echo -e "\e[36m>>>>>>installing mysql<<<<<<<<\e[0m"
yum install mysql -y

echo -e "\e[36m>>>>>>calling the service<<<<<<<<\e[0m"
mysql -h mysql-dev.sujianilsrisriyaan.online -uroot -pRoboShop@1 /app/schema/shipping.sql

echo -e "\e[36m>>>>>>restarting the service<<<<<<<<\e[0m"
echo -e "\e[36m>>>>>>Creloading the service<<<<<<<<\e[0m"
systemctl daemon-reload

echo -e "\e[36m>>>>>>starting and enabling service<<<<<<<<\e[0m"
systemctl enable shipping
systemctl restart shipping

