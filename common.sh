app_user=roboshop
script=$(realpath "0")
script_path=$(dirname "$script")

func_print_head() {
  echo -e "\e[36m>>>>>>>>> $1 <<<<<<<<<<\e[0m"
}

fun_stat_check() {
if [ $1 -eq 0 ]; then
    echo -e "\e[31m SUCCESS \e[0m"
  else
    echo -e "\e[31m FAILURE \e[0m"
    exit 1
  fi
}
func_schema_setup() {
  if [ "$schema_setup" == "mongo" ]; then
   func_print_head "Copy MongoDB repo"
   cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo
   func_stat_check $?

   func_print_head "Install Mongodb Client"
   yum install mongodb-org-shell -y
   func_stat_check $?

   func_print_head "Load Schema"
   mongo --host mongodb-dev.sujianilsrisriyaan.online < /app/schema/${component}.js
   func_stat_check $?
  fi
  if [ "${schema_setup}" == "mysql" ]; then

    func_print_head "install mysql client"
    yum install mysql -y
    func_stat_check $?

    func_print_head "Load Schema"
    mysql -h mysql-dev.sujianilsrisriyaan.online -uroot -p${mysql_root_password} < /app/schema/${component}.sql
    func_stat_check $?

}
func_app_prereq() {
  func_print_head "Add Application User"
    useradd ${app_user}
    func_stat_check $?

    func_print_head "Creating Application Directory"
    rm -rf /app
    mkdir /app
    func_stat_check $?

    func_print_head "Downloading Application Content"
    curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
    func_stat_check $?

    func_print_head "CHANGING TO Application DIRECTORY"
    cd /app

    func_print_head "Extracting the Application Content"
    unzip /tmp/${component}.zip
    func_stat_check $?
}
   func_systemd_setup() {
    func_print_head "setup SystemD service"
    cp ${script_path}/${component}.service /etc/systemd/system/${component} b .service
    func_stat_check $?

    func_print_head "restart the ${component} service"
    systemctl daemon-reload
    systemctl enable ${component}
    systemctl restart ${component}
    func_stat_check $?
}

  func_nodejs() {
  func_print_head "Downloading NodeJS source"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash
  func_stat_check $?

  func_print_head "installing NodeJS"
  yum install nodejs -y
  func_stat_check $?

  func_app_prereq

  func_print_head "Install NodeJS Dependencies"
  npm install
  func_stat_check $?

  func_schema_setup
  func_systemd_service



}
func_java() {
  func_print_head "install maven"
  yum install maven -y

  func_stat_check $?

  func_app_prereq
  func_print_head "clean maven package"
  mvn clean package
  func_stat_check $?

  func_print_head "move file"
  mv target/${component}-1.0.jar ${component}.jar

  func_schema_setup
  func_systemd_setup


}