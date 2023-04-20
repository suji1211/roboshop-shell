script=$(realpath "0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

func_print_head() {
  echo -e "\e[36m>>>>>>>>> $1 <<<<<<<<<<\e[0m"
}

func_print_head  "install redis repo"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y

func_print_head  "install redis"
dnf module enable redis:remi-6.2 -y
yum install redis -y

func_print_head  "update redis listen address"
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/redis.conf /etc/redis/redis.conf

func_print_head  "start redis service"
systemctl enable redis
systemctl restart redis
