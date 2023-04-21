script=$(realpath "0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

component=dispatch
func_print_head "installing golang"
yum install golang -y

func_app_prereq

func_print_head "dispatching commands"
go mod init dispatch
go get
go build

 func_systemd_setup