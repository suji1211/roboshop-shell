app_user=roboshop
script=$(realpath "0")
script_path=$(dirname "$script")

func_print_head() {
  echo -e "\e[36m>>>>>>>>> $1 <<<<<<<<<<\e[0m"
}

func_nodejs() {
  func_print_head "Downloading NodeJS source"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash

  func_print_head "installing NodeJS"
  yum install nodejs -y

  func_print_head "Add application User"
  useradd ${app_user}

  func_print_head "Creating app Directory"
  rm -rf /app
  mkdir /app

  func_print_head "Downloading App Content"
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip

  func_print_head "CHANGING TO APP DIRECTORY"
  cd /app

  func_print_head "Extracting the App Content"
  unzip /tmp/${component}.zip

  func_print_head "Install NodeJS Dependencies"
  npm install

  func_print_head copying cart service
  cp ${script_path}/${component}.service /etc/systemd/system/${component}.service

  func_print_head "service reload"
  systemctl daemon-reload

  func_print_head "Restarting the service"
  systemctl enable ${component}
  systemctl start ${component}

}