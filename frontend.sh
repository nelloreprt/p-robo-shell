component=frontend

source common.sh

PRINT_HEAD "install nginx"
yum install nginx -y  &>> /tmp/roboshop.log
STATUS_CHECK

PRINT_HEAD "removing the default content"
rm -rf /usr/share/nginx/html/*  &>> /tmp/roboshop.log
STATUS_CHECK

PRINT_HEAD "change directory to >> /usr/share/nginx/html "
cd /usr/share/nginx/html  &>> /tmp/roboshop.log
STATUS_CHECK

PRINT_HEAD "download the frontend content"
curl -o /tmp/{component}.zip https://roboshop-artifacts.s3.amazonaws.com/{component}.zip  &>> /tmp/roboshop.log
STATUS_CHECK

PRINT_HEAD "extract the frontend content"
unzip /tmp/{component}.zip  &>> /tmp/roboshop.log
STATUS_CHECK

PRINT_HEAD "copy roboshop.conf"
cp ${path}/files/roboshop.conf /etc/nginx/default.d/roboshop.conf  &>> /tmp/roboshop.log
STATUS_CHECK

PRINT_HEAD "enable nginx"
systemctl enable nginx  &>> /tmp/roboshop.log
STATUS_CHECK

PRINT_HEAD "start nginx"
systemctl start nginx  &>> /tmp/roboshop.log
STATUS_CHECK

PRINT_HEAD "restart nginx"
systemctl restart nginx   &>> /tmp/roboshop.log
STATUS_CHECK



