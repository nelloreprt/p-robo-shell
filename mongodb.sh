component=mongod

source common.sh

PRINT_HEAD "Setup the MongoDB repo file"
cp ${path}/files/mongo.repo /etc/yum.repos.d/mongo.repo  &>> /tmp/roboshop.log
STATUS_CHECK

PRINT_HEAD "install mongodb"
yum install mongodb-org -y  &>> /tmp/roboshop.log
STATUS_CHECK

PRINT_HEAD "Update listen address from 127.0.0.1 to 0.0.0.0"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/{component}.conf  &>> /tmp/roboshop.log
STATUS_CHECK

PRINT_HEAD "enable mongodb"
systemctl enable {component}   &>> /tmp/roboshop.log
STATUS_CHECK

PRINT_HEAD "start mongodb"
systemctl start {component}  &>> /tmp/roboshop.log
STATUS_CHECK

PRINT_HEAD "restart mongodb"
systemctl restart {component}   &>> /tmp/roboshop.log
STATUS_CHECK

