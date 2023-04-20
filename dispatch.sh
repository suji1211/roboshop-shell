script=$(realpath "0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

func_print_head() {
  echo -e "\e[36m>>>>>>>>> $1 <<<<<<<<<<\e[0m"
}
func_print_head "installing golang"
yum install golang -y

func_print_head "Adding application user"
useradd ${app_user}

func_print_head "Creating app directory"
rm -rf /app
mkdir /app

func_print_head "downloading dispatch file"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip

func_print_head "changing to app directory"
cd /app

func_print_head "unzipping the content"
unzip /tmp/dispatch.zip

func_print_head "dispatching commands"
go mod init dispatch
go get
go build

func_print_head "coping the dispatch service"

cp ${script_path}/dispatch.service /etc/systemd/system/dispatch.service

func_print_head "loading the service"
systemctl daemon-reload

func_print_head  "starting and enabling service"
systemctl enable dispatch
systemctl restart dispatch