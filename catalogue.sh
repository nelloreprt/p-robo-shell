component=catalogue

load_schema=true
schema_type=mongo

component_type=nodejs
source common.sh

NODEJS

APP_PREREQ

load_schema

systemd_setup

# this step is integral part of load_schema, so the same will be used in catalogue.sh from common.sh(load_schema)
# PRINT_HEAD "Setup the MongoDB repo file"
# cp ${path}/files/mongo.repo /etc/yum.repos.d/mongo.repo  &>> /tmp/roboshop.log
# STATUS_CHECK










