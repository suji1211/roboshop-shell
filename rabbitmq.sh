echo -e "\e[36m>>>>>>downloading raberlang <<<<<<<<\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash

echo -e "\e[36m>>>>>>Installing erlang<<<<<<<<\e[0m"
yum install erlang -y

echo -e "\e[36m>>>>>>downloading rabbitmq<<<<<<<<\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash

echo -e "\e[36m>>>>>>Installing rabbitmq<<<<<<<<\e[0m"
yum install rabbitmq-server -y

echo -e "\e[36m>>>>>> enabling rabbitmq server<<<<<<<<\e[0m"
systemctl enable rabbitmq-server

echo -e "\e[36m>>>>>>restarting rabbitmq server<<<<<<<<\e[0m"
systemctl start rabbitmq-server

echo -e "\e[36m>>>>>> adding user<<<<<<<<\e[0m"
rabbitmqctl add_user roboshop roboshop123

echo -e "\e[36m>>>>>>Setting permissions to user<<<<<<<<\e[0m"
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"