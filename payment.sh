component=payment

source common.sh

PRINT_HEAD "install python"
yum install python36 gcc python3-devel -y  &>> /tmp/roboshop.log
STATUS_CHECK

APP_PREREQ

PRINT_HEAD "Download Dependencies"
cd /app  &>> /tmp/roboshop.log
pip3.6 install -r requirements.txt &>> /tmp/roboshop.log
STATUS_CHECK

systemd_setup


