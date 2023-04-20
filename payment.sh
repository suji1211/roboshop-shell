script=$(realpath "0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
rabbitmq_appuser_password=$1

func_print_head() {
  echo -e "\e[36m>>>>>>>>> $1 <<<<<<<<<<\e[0m"
}

func_print_head "installing python"
yum install python36 gcc python3-devel -y

func_print_head "adding application user"
useradd ${app_user}

func_print_head "creating app DIRECTORY"
rm -rf /app
mkdir /app

func_print_head "downloading payment service"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip

func_print_head "CHANGING TO APP DIRECTORY"
cd /app

func_print_head "extracting the payment service"
unzip /tmp/payment.zip

func_print_head "Installing pip 3.6 requirements"
pip3.6 install -r requirements.txt

func_print_head "copying payment.service"
sed -i -e "s|rabbitmq_appuser_password|${rabbitmq_appuser_password}|" ${script_path}/payment.service
cp ${script_path}/payment.service /etc/systemd/system/payment.service


func_print_head "reloading the service"
systemctl daemon-reload

func_print_head "Enabling and starting the service"
systemctl enable payment
systemctl restart payment