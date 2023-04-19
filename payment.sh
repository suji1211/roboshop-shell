echo -e "\e[36m>>>>>>installing python<<<<<<<<\e[0m"
yum install python36 gcc python3-devel -y

echo -e "\e[36m>>>>>>adding appication user<<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>>>>creating app DIRECTORY<<<<<<<<\e[0m"
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
cp /home/centos/roboshop-shell/payment.service /etc/systemd/system/payment.service


echo -e "\e[36m>>>>>>reloading the service<<<<<<<<\e[0m"
systemctl daemon-reload

echo -e "\e[36m>>>>>>Enablng and starting the service<<<<<<<<\e[0m"
systemctl enable payment
systemctl start payment