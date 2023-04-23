script=$(realpath "0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

func_print_head "download rabbitmq and erlang supporting file"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>$log_file
func_stat_check $?

func_print_head "install erlang"
yum install erlang -y &>>$log_file
func_stat_check $?

func_print_head "download rabbitmq and erlang supporting file"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>$log_file
func_stat_check $?

func_print_head "install rabbitmq supporting file"
yum install rabbitmq-server -y &>>$log_file
func_stat_check $?

func_print_head "Enable and restart server"
systemctl enable rabbitmq-server &>>$log_file
systemctl start rabbitmq-server &>>$log_file
func_stat_check $?

func_print_head "Setting username and password"
rabbitmqctl add_user roboshop roboshop123 &>>$log_file
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$log_file
func_stat_check $?