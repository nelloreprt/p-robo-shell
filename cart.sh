component=catalogue
load_schema=false
component_type=nodejs

source common.sh

NODEJS

APP_PREREQ

load_schema

systemd_setup

# this step is already done in mongodb, so not required in catalogue.sh
# PRINT_HEAD "Setup the MongoDB repo file"
# cp ${path}/files/mongo.repo /etc/yum.repos.d/mongo.repo  &>> /tmp/roboshop.log
# STATUS_CHECK