# to check if the variable "roboshop_mysql_password" is empty or not
# if variable is empty then -z = true >> enter roboshop_mysql_password
if [ -z ${root_mysql_password} ]
then
  echo “enter root_mysql_password”
exit
fi

component=shipping

component_type=shipping

load_schema=true
schema_type=mysql

source common.sh

PRINT_HEAD "install maven"
yum install maven -y  &>> /tmp/roboshop.log
STATUS_CHECK

APP_PREREQ

systemd_setup

load_schema

