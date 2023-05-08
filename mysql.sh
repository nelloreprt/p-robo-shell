# to check if the variable "roboshop_mysql_password" is empty or not
# if variable is empty then -z = true >> enter roboshop_mysql_password
if [ -z "roboshop_{component}_password"]
then
  echo -e "\e[31m enter roboshop_{component}_password \e[0m"
fi

component=mysql
source common.sh

PRINT_HEAD "disable MySQL 8 version"
dnf module disable {component} -y   &>> /tmp/roboshop.log
STATUS_CHECK

PRINT_HEAD "copy roboshop.conf"
cp ${path}/files/{component}.repo /etc/yum.repos.d/{component}.repo  &>> /tmp/roboshop.log
STATUS_CHECK

PRINT_HEAD "install mysql"
yum install {component}-community-server -y  &>> /tmp/roboshop.log
STATUS_CHECK

PRINT_HEAD "enable mysql"
systemctl enable mysqld  &>> /tmp/roboshop.log
STATUS_CHECK

PRINT_HEAD "start mysql"
systemctl start mysqld   &>> /tmp/roboshop.log
STATUS_CHECK

PRINT_HEAD "changing the default password"
mysql_secure_installation --set-root-pass {roboshop_{component}_password}
STATUS_CHECK

PRINT_HEAD "check password working status"
mysql -uroot -p{roboshop_{component}_password}
STATUS_CHECK