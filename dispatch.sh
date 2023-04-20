script=$(realpath "0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
echo -e "\e[36m>>>>>>installing golang<<<<<<<<\e[0m"
yum install golang -y

echo -e "\e[36m>>>> adding application user<<<<<<<\e[0m"
useradd ${app_user}

echo -e "\e[36m>>>>>>Creating ap[p directory<<<<<<<<\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[36m>>>>>>downloading dispatch file<<<<<<<<\e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip

echo -e "\e[36m>>>>>> changing to app directory <<<<<<<<\e[0m"
cd /app

echo -e "\e[36m>>>>>>unzipping the content<<<<<<<<\e[0m"
unzip /tmp/dispatch.zip

echo -e "\e[36m>>>>>>dispatching the commands<<<<<<<<\e[0m"
go mod init dispatch
go get
go build

echo -e "\e[36m>>>>>>coping the dispatch service<<<<<<<<\e[0m"

cp ${script_path}/dispatch.service /etc/systemd/system/dispatch.service

echo -e "\e[36m>>>>>>loading the service<<<<<<<<\e[0m"

systemctl daemon-reload

echo -e "\e[36m>>>>>> starting and enabling service<<<<<<<<\e[0m"
systemctl enable dispatch
systemctl restart dispatch