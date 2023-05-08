component=shipping

component_type=shipping

load_schema=true
schema_type=mysql

source common.sh

PRINT_HEAD "install maven"
yum install maven -y  &>> /tmp/roboshop.log
STATUS_CHECK

PRINT_HEAD "install maven"
yum install maven -y  &>> /tmp/roboshop.log
STATUS_CHECK

APP_PREREQ

systemd_setup

load_schema

