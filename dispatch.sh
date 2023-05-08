component=dispatch

source common.sh

PRINT_HEAD "install golang"
yum install golang -y  &>> /tmp/roboshop.log
STATUS_CHECK

APP_PREREQ

PRINT_HEAD "Download Dependencies"
cd /app  &>> /tmp/roboshop.log
go mod init dispatch &>> /tmp/roboshop.log
go get  &>> /tmp/roboshop.log
go build &>> /tmp/roboshop.log
STATUS_CHECK

systemd_setup
