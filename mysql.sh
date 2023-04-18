echo -e "\e[36m>>>>>>disabling the mysql<<<<<<<<\e[0m"
dnf module disable mysql -y

echo -e "\e[36m>>>>>>coping mysql repo file<<<<<<<<\e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo

echo -e "\e[36m>>>>>>Installing mysql server<<<<<<<<\e[0m"
yum install mysql-community-server -y

echo -e "\e[36m>>>>>> enabling my sql<<<<<<<\e[0m"
systemctl enable mysqld

echo -e "\e[36m>>>>>>starting the service<<<<<<<\e[0m"
systemctl start mysqld

echo -e "\e[36m>>>>>>resetting mysql password<<<<<<<<\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1