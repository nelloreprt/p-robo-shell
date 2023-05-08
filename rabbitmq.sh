# to check if the variable "roboshop_rabbitmq_password" is empty or not
# if variable is empty then -z = true >> enter roboshop_rabbitmq_password
if [ -z "roboshop_rabbitmq_password"]
then
  echo -e "\e[31m enter roboshop_rabbitmq_password \e[0m"
fi

source common.sh

PRINT_HEAD "configuring yum repos"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash  &>> /tmp/roboshop.log
STATUS_CHECK

PRINT_HEAD "install erlang"
yum install erlang -y  &>> /tmp/roboshop.log
STATUS_CHECK

PRINT_HEAD "configure yum repos"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash  &>> /tmp/roboshop.log
STATUS_CHECK

PRINT_HEAD "install rabbitmq"
yum install rabbitmq-server -y  &>> /tmp/roboshop.log
STATUS_CHECK

PRINT_HEAD "enable rabbitmq"
systemctl enable rabbitmq-server
STATUS_CHECK

PRINT_HEAD "start rabbitmq"
systemctl start rabbitmq-server
STATUS_CHECK

PRINT_HEAD "creating user"
rabbitmqctl list_users | grep roboshop
if [$? -ne 0]
then
rabbitmqctl add_user roboshop ${roboshop_rabbitmq_password}
fi
STATUS_CHECK

PRINT_HEAD "creating user"
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
STATUS_CHECK

