source common.sh
echo -e "\e[36m>>>>>>>>> downloading nodejs file <<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[36m>>>>>>>>> Installing nodejs <<<<<<\e[0m"
yum install nodejs -y

echo -e "\e[36m>>>>>>>>> user add <<<<<<\e[0m"
useradd ${app_user}

echo -e "\e[36m>>>>>>>>> mkdir directory <<<<<<\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[36m>>>>>>>>> downloading catalogue file <<<<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip

echo -e "\e[36m>>>>>>>>> changing directory <<<<<<\e[0m"
cd /app

echo -e "\e[36m>>>>>>>>>Unzipping the file <<<<<<\e[0m"
unzip /tmp/catalogue.zip

echo -e "\e[36m>>>>>>>>> installing dependencies <<<<<<\e[0m"
npm install

echo -e "\e[36m>>>>>>>>> coping catalogue file <<<<<<\e[0m"
cp /home/centos/roboshop-shell/catalogue.service /etc/systemd/system/catalogue.service

echo -e "\e[36m>>>>>>>>> restarting nodejs <<<<<<\e[0m"
systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue

echo -e "\e[36m>>>>>>>>> mongo config file <<<<<<\e[0m"
cp /home/centos/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[36m>>>>>>>>> installing file <<<<<<\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[36m>>>>>>>>> mexecuting mongo file <<<<<<\e[0m"
mongo --host mongodb-dev.sujianilsrisriyaan.online </app/schema/catalogue.js