script=$(realpath "0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

func_print_head "installing python36"
yum install python36 gcc python3-devel -y

func_print_head "adding application user"
useradd roboshop

func_print_head "creating directory"
rm -rf /app
mkdir /app

func_print_head "downloading and unzipping the content"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip
cd /app
unzip /tmp/payment.zip

func_print_head "Installing dependencies"
cd /app
pip3.6 install -r requirements.txt

func_print_head "Reloading the service"
systemctl daemon-reload

func_print_head "Restarting the service"
systemctl enable payment
systemctl start payment