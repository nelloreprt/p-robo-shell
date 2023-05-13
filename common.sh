# declaring command_variable for path, which is required for every component
path=$(pwd)

STATUS_CHECK() {
  if [echo $? -eq 0 ]
  then
    echo SUCCESS
  else
    echo FAILURE
  fi
}

PRINT_HEAD() {
  echo -e "\e[31m $1 \e[0m"
}

NODEJS() {
  PRINT_HEAD "Setup NodeJS repos"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>> /tmp/roboshop.log
  STATUS_CHECK

  PRINT_HEAD "Install NodeJS"
  yum install nodejs -y &>> /tmp/roboshop.log
  STATUS_CHECK
}


APP_PREREQ() {
  PRINT_HEAD "Add application User"
  id roboshop &>> /tmp/roboshop.log
  if [ $? -ne 0 ]
  then
  useradd roboshop &>> /tmp/roboshop.log
  fi
  STATUS_CHECK

  PRINT_HEAD "setup an app directory."
  mkdir -p /app &>> /tmp/roboshop.log
  STATUS_CHECK

  PRINT_HEAD "remove all the content inside the /app_directory"
  rm -rf /app/* &>> /tmp/roboshop.log
  STATUS_CHECK

  PRINT_HEAD "Download the application code"
  curl -o /tmp/{component}.zip https://roboshop-artifacts.s3.amazonaws.com/{component}.zip &>> /tmp/roboshop.log
  cd /app &>> /tmp/roboshop.log
  unzip /tmp/{component}.zip &>> /tmp/roboshop.log
  STATUS_CHECK

if [{component_type} == nodejs]
then
  PRINT_HEAD "Download Dependencies-nodejs"
  cd /app &>> /tmp/roboshop.log
  npm install &>> /tmp/roboshop.log
  STATUS_CHECK

else
  PRINT_HEAD "Download Dependencies-maven"
  cd /app
  mvn clean package
  mv target/shipping-1.0.jar shipping.jar
  STATUS_CHECK
fi

}

systemd_setup() {
  PRINT_HEAD "copy catalogue.service"
  cp ${path}/files/{component}.service /etc/systemd/system/{component}.service  &>> /tmp/roboshop.log
  STATUS_CHECK

  PRINT_HEAD "daemon reload"
  systemctl daemon-reload  &>> /tmp/roboshop.log
  STATUS_CHECK

  PRINT_HEAD "enable service"
  systemctl enable {component}  &>> /tmp/roboshop.log
  STATUS_CHECK

  PRINT_HEAD "start service"
  systemctl start {component}  &>> /tmp/roboshop.log
  STATUS_CHECK
}

load_schema() {
if [${load_schema} == true]
then
if [${schema_type} == mongo]
  PRINT_HEAD "Setup the MongoDB repo file"
  cp ${path}/files/mongo.repo /etc/yum.repos.d/mongo.repo  &>> /tmp/roboshop.log
  STATUS_CHECK

  PRINT_HEAD "install mongodb-client"
  yum install mongodb-org-shell -y &>> /tmp/roboshop.log
  STATUS_CHECK

  PRINT_HEAD "load schema"
  mongo --host MONGODB-SERVER-IPADDRESS </app/schema/{component}.js  &>> /tmp/roboshop.log
  STATUS_CHECK

else
  PRINT_HEAD "install mysql-client"
  yum install mysql -y  &>> /tmp/roboshop.log
  STATUS_CHECK

  PRINT_HEAD "load schema"
  mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pRoboShop@1 < /app/schema/{component}.sql   &>> /tmp/roboshop.log
  STATUS_CHECK

  PRINT_HEAD "restart shipping"
  systemctl restart {component}
  STATUS_CHECK
fi
fi
}
