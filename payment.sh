script=$(realpath "0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
rabbit_appuser_password=$1

echo -e "\e[36m>>>>>>installing python<<<<<<<<\e[0m"
yum install python36 gcc python3-devel -y

echo -e "\e[36m>>>>>>adding application user<<<<<<<<\e[0m"
useradd ${app_user}

echo -e "\e[36m>>>>>>creating app DIRECTORY<<<<<<<<\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[36m>>>>>>downloading payment service<<<<<<<<\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip

echo -e "\e[36m>>>>>>CHANGING TO APP DIRECTORY<<<<<<<<\e[0m"
cd /app

echo -e "\e[36m>>>>>>extracting the payment service<<<<<<<<\e[0m"
unzip /tmp/payment.zip

echo -e "\e[36m>>>>>>Installing pip 3.6 requirements<<<<<<<<\e[0m"
pip3.6 install -r requirements.txt

echo -e "\e[36m>>>>>>copying payment.service<<<<<<<<\e[0m"
sed -i -e "s|rabbit_appuser_password|${rabbitmq_appuser_password}|" ${script_path}/payment.service
cp ${script_path}/payment.service /etc/systemd/system/payment.service


echo -e "\e[36m>>>>>>reloading the service<<<<<<<<\e[0m"
systemctl daemon-reload

echo -e "\e[36m>>>>>>Enabling and starting the service<<<<<<<<\e[0m"
systemctl enable payment
systemctl restart payment