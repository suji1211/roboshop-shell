echo -e "\e[36m>>>>>>>>> mongo config file <<<<<<\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[36m>>>>>>>> installing mongo file <<<<<<<<<<< \e[0m"
yum install mongodb-org -y

echo -e "\e[36m>>>>>>>> changing 127.0.0.1 to 0.0.0.0 <<<<<<<<<<< \e[0m"
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/mongod.conf

echo -e "\e[36m>>>>>>>> restarting mongo file <<<<<<<<<<< \e[0m"
systemctl enable mongod
systemctl start mongod

#edit the file replace 127.0.0.1 with 0.0.0.0