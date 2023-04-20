script=$(realpath "0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

func_print_head() {
  echo -e "\e[36m>>>>>>>>> $1 <<<<<<<<<<\e[0m"
}

func_print_head "installing nginx"
yum install nginx -y

func_print_head "configuring file"
cp roboshop.conf /etc/nginx/default.d/roboshop.conf

func_print_head "Removing Nginx data"
rm -rf /usr/share/nginx/html/*

func_print_head "downloading file"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
cd /usr/share/nginx/html

func_print_head "unzip the file"
unzip /tmp/frontend.zip

func_print_head "restarting  nginx"
systemctl restart nginx
systemctl enable nginx
