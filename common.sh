app_user=roboshop
script_path=${/home/centos/roboshop-shell}

func_nodejs() {
  echo -e "\e[36m>>>>>>copdownloading node sourse<<<<<<<<\e[0m"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash

  echo -e "\e[36m>>>>>>installing nodejs<<<<<<<<\e[0m"
  yum install nodejs -y

  echo -e "\e[36m>>>>>>adding application user<<<<<<<<\e[0m"
  useradd ${app_user}

  echo -e "\e[36m>>>>>>creating app directory<<<<<<<<\e[0m"
  rm -rf /app
  mkdir /app

  echo -e "\e[36m>>>>>>coping mongo repo<<<<<<<<\e[0m"
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip

  echo -e "\e[36m>>>>>>CHANGING TO APP DIRECTORY<<<<<<<<\e[0m"
  cd /app

  echo -e "\e[36m>>>>>>EXTRACTING THE CART FILE<<<<<<<<\e[0m"
  unzip /tmp/${component}.zip

  echo -e "\e[36m>>>>>>npm file installation<<<<<<<<\e[0m"
  npm install

  echo -e "\e[36m>>>>>>copying cart service<<<<<<<<\e[0m"
  cp ${script_path}/${component}.service /etc/systemd/system/${component}.service

  echo -e "\e[36m>>>>>>service reload<<<<<<<<\e[0m"
  systemctl daemon-reload

  echo -e "\e[36m>>>>>>restarting the service<<<<<<<\e[0m"
  systemctl enable ${component}
  systemctl start ${component}

}