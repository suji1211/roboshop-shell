script=$(realpath "0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

func_print_head "installing nginx"
yum install nginx -y &>>$log_file
func_stat_check $?

func_print_head "copy roboshop config file"
cp roboshop.conf /etc/nginx/default.d/roboshop.conf &>>$log_file
func_stat_check $?

func_print_head "Removing old App content "
rm -rf /usr/share/nginx/html/* &>>$log_file
func_stat_check $?

func_print_head "Download App Content"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>$log_file
func_stat_check $?

func_print_head "Changing directory"
cd /usr/share/nginx/html &>>$log_file

func_print_head "Extracting the App Content"
unzip /tmp/frontend.zip &>>$log_file
func_stat_check $?

func_print_head "restarting  nginx"
systemctl enable nginx &>>$log_file
systemctl restart nginx &>>$log_file
func_stat_check $?
