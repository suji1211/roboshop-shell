echo -e "\e[36m>>>>>>>> installing nginx <<<<<<<<<<< \e[0m"
yum install nginx -y

echo -e "\e[36m>>>>>>>> restarting nginxx <<<<<<<<<<< \e[0m"
systemctl status nginx
systemctl enable nginx
systemctl start nginx

echo -e "\e[36m>>>>>>>> configuring file <<<<<<<<<<< \e[0m"
cp roboshop.conf /etc/nginx/default.d/roboshop.conf

echo -e "\e[36m>>>>>>>> Removing Nginx data <<<<<<<<<<< \e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[36m>>>>>>>> downloading file <<<<<<<<<<< \e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
cd /usr/share/nginx/html

echo -e "\e[36m>>>>>>>> unzip the file <<<<<<<<<<< \e[0m"
unzip /tmp/frontend.zip

echo -e "\e[36m>>>>>>>> restarting  nginx <<<<<<<<<<< \e[0m"

systemctl restart nginx
