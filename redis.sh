
source common.sh

PRINT_HEAD "install redis repos"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y  &>> /tmp/roboshop.log
STATUS_CHECK

PRINT_HEAD "enable redis "
dnf module enable redis:remi-6.2 -y  &>> /tmp/roboshop.log
STATUS_CHECK

PRINT_HEAD "install redis "
yum install redis -y  &>> /tmp/roboshop.log
STATUS_CHECK

PRINT_HEAD " Update listen address from 127.0.0.1 to 0.0.0.0 in /etc/redis.conf"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf  &>> /tmp/roboshop.log
STATUS_CHECK

PRINT_HEAD " Update listen address from 127.0.0.1 to 0.0.0.0 in /etc/redis/redis.conf"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf  &>> /tmp/roboshop.log
STATUS_CHECK

PRINT_HEAD " enable redis "
systemctl enable redis   &>> /tmp/roboshop.log
STATUS_CHECK

PRINT_HEAD " start redis "
systemctl start redis  &>> /tmp/roboshop.log
STATUS_CHECK









