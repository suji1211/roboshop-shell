echo -e "\e[36m>>>>>> downloading nodejs<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[36m>>>>>> installing nodejs<<<<<<<<\e[0m"
yum install nodejs -y

echo -e "\e[36m>>>>>> adding service user<<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>>>> creating app directory<<<<<<<<\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[36m>>>>>> downloading repo<<<<<<<<\e[0m"
curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip

echo -e "\e[36m>>>>>> changing to app directory<<<<<<<<\e[0m"
cd /app

echo -e "\e[36m>>>>>> unzipping the content<<<<<<<<\e[0m"
unzip /tmp/user.zip

echo -e "\e[36m>>>>>> installing dependencies<<<<<<<<\e[0m"
npm install

echo -e "\e[36m>>>>>> coping user service <<<<<<<<\e[0m"
cp /home/centos/roboshop-shell/user.service /etc/systemd/system/user.service

echo -e "\e[36m>>>>>> service reload<<<<<<<<\e[0m"
systemctl daemon-reload

echo -e "\e[36m>>>>>> enabling user service<<<<<<<<\e[0m"
systemctl enable user
systemctl start user

echo -e "\e[36m>>>>>>coping mongo repo<<<<<<<<\e[0m"
cp /home/centos/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[36m>>>>>> installing mongo<<<<<<<<\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[36m>>>>>> loading schema<<<<<<<<\e[0m"
mongo --host mongodb-dev.sujianilsrisriyaan.online /app/schema/user.js