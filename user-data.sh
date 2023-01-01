#!/bin/bash

#===================================================================================================================#
#                                                                                                                   #
#  @License Starts                                                                                                  #
#                                                                                                                   #
#  Copyright © 2015 - present. MongoExpUser.  All Rights Reserved.                                                  #
#                                                                                                                   #
#  License: MIT                                                                                                     #
#                                                                                                                   #
#  @License Ends                                                                                                    #
#                                                                                                                   #
#...................................................................................................................#
#                                                                                                                   #
#  user-data.sh (lauch/start-up script)                                                                             #
#===================================================================================================================#


# set permission on main directories
sudo chmod 775 /home
sudo chmod 775 /home/ubuntu

# define common variable(s)
base_dir="base"
server_dir="server"
client_dir="client"
enable_web_server=true
enable_redis_stack_server=true
redis_data_dir="/var/lib/redis-stack/data"


clean_system () {
      sudo chmod 775 /var/lib/apt/lists/
      sudo rm -rf /var/lib/apt/lists/*
      echo -e "Y"
      echo -e "Y"
      echo -e "Y"
      sudo apt-get -y autoclean
      echo -e "Y"
      echo -e "Y"
      echo -e "Y"
      sudo apt-get -y autoremove
      echo -e "Y"
      echo -e "Y"
      echo -e "Y"
}


create_dir_and_install_missing_packages () {
      # create directories
      cd /home/
      sudo mkdir $base_dir
      cd $base_dir
      sudo mkdir $server_dir
      sudo mkdir $client_dir

      # update system
      sudo apt-get -y update

      # install additional packages
      sudo apt-get -y install nfs-common
      sudo apt-get -y install sshpass
      sudo apt-get -y install cmdtest
      sudo apt-get -y install spamassassin
      sudo apt-get -y install snap
      sudo apt-get -y install nmap
      sudo apt-get -y install net-tools
      sudo apt-get -y install aptitude
      sudo apt-get -y install build-essential
      sudo apt-get -y install certbot
      sudo apt-get -y install python3-certbot-apache
      sudo apt-get -y install systemd
      sudo apt-get -y install procps
      sudo apt-get -y install nano
      sudo apt-get -y install apt-utils
      sudo apt-get -y install wget
      sudo apt-get -y install curl
      sudo apt-get -y install gcc
      sudo apt-get -y install gnupg
      sudo apt-get -y install gnupg2
      sudo apt-get -y install make
      sudo apt-get -y install sshpass
      sudo apt-get -y install cmdtest
      sudo apt-get -y install snapd
      sudo apt-get -y install screen
      sudo apt-get -y install spamc
      sudo apt-get -y install parted
      sudo apt-get -y install iputils-ping
      sudo apt-get -y install unzip
      sudo apt-get -y install gzip
      sudo apt-get -y openssl
      sudo apt-get -y tcl-tls
      sudo apt-get -y make
      sudo apt-get -y install xfsprogs
      sudo modprobe -v xfs
      sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
      echo -e "Y"
      sudo chmod 777 awscliv2.zip
      sudo unzip awscliv2.zip
      sudo ./aws/install
      sudo apt-get -y install python3

      # clean
      clean_system
}


install_and_configure_nodejs_web_server () {
      cd /home/
      cd $base_dir
      
      if [ $enable_web_server = true ]; then
        
        # install node.js - version 19
        curl -sL https://deb.nodesource.com/setup_19.x | sudo -E bash -
        echo -e "\n"
        sudo apt-get install -y nodejs
        echo -e "\n"
            
        # create package.json file
        sudo echo ' {
          "name": "Nodejs-Expressjs",
          "version": "1.0",
          "description": "A web server, based on the Node.js-Express.js (NE) stack",
          "license": "MIT",
          "main": "./app.js",
          "email": "info@domain.com",
          "author": "Copyright © 2015 - present. MongoExpUser.  All Rights Reserved.",
          "dependencies"    :
          {
            "express"       : "*"
          },
          "devDependencies": {},
          "keywords": [
            "Node.js",
            "Express.js",
            "Redis-Stack\""
          ]
        }' > package.json
        # a. basic modules 
        sudo npm install express@5.0.0-alpha.8
        sudo npm install -g npm
        sudo npm install bcryptjs
        sudo npm install bcrypt-nodejs
        sudo npm install bindings
        sudo npm install bluebird
        sudo npm install body-parser
        sudo npm install command-exists
        sudo npm install compression
        sudo npm install connect-flash
        sudo npm install cookie-parser
        sudo npm install express-session
        sudo npm install formidable
        sudo npm install html-minifier
        sudo npm install jsdom
        sudo npm install jsonschema
        sudo npm install level
        sudo npm install memored
        sudo npm install mime
        sudo npm install mkdirp
        sudo npm install ocsp
        sudo npm install pg
        sudo npm install python-shell
        sudo npm install s3-proxy
        sudo npm install s3-node-client
        sudo npm install serve-favicon
        sudo npm install serve-index
        sudo npm install uglify-js2
        sudo npm install uglify-js@2.2.0
        sudo npm install uglifycss
        sudo npm install uuid
        sudo npm install vhost
        sudo npm install @faker-js/faker@7.3.0  # faker should be v7.3.0 or v7.3.0+
        sudo npm install mongodb
        sudo npm install namesilo-domain-api
        sudo npm install xml2js
        # b.  db modules/drivers
        sudo npm install gremlin
        sudo npm install mongodb
        sudo npm install mysql 
        sudo npm install @mysql/xdevapi
        sudo npm install neo4j-driver
        sudo npm install redis
        sudo npm install sqlite3
        # c. all modules of aws sdk for javaScript/node.sj v2
        sudo npm install aws-sdk
        # d. selected modules of aws sdk for javascript/node.sj v3
        sudo npm install @aws-sdk/client-apigatewayv2
        sudo npm install @aws-sdk/client-comprehend
        sudo npm install @aws-sdk/client-comprehendmedical
        sudo npm install @aws-sdk/client-dynamodb @aws-sdk/lib-dynamodb 
        sudo npm install @aws-sdk/client-efs
        sudo npm install @aws-sdk/client-opensearch
        sudo npm install @aws-sdk/client-opensearchserverless
        sudo npm install @aws-sdk/client-firehose
        sudo npm install @aws-sdk/client-lambda
        sudo npm install @aws-sdk/client-lex-model-building-service
        sudo npm install @aws-sdk/client-lex-models-v2
        sudo npm install @aws-sdk/client-lex-runtime-service
        sudo npm install @aws-sdk/client-lex-runtime-v2
        sudo npm install @aws-sdk/client-mq
        sudo npm install @aws-sdk/client-mwaa
        sudo npm install @aws-sdk/client-neptune
        sudo npm install @aws-sdk/client-opensearch
        sudo npm install @aws-sdk/client-polly
        sudo npm install @aws-sdk/client-redshift
        sudo npm install @aws-sdk/client-redshift-data
        sudo npm install @aws-sdk/client-redshiftserverless
        sudo npm install @aws-sdk/client-rekognition
        sudo npm install @aws-sdk/client-rds
        sudo npm install @aws-sdk/client-rds-data
        sudo npm install @aws-sdk/client-s3 @aws-sdk/lib-storage
        sudo npm install @aws-sdk/client-sns
        sudo npm install @aws-sdk/client-timestream-query
        sudo npm install @aws-sdk/client-timestream-write
        sudo npm install @aws-sdk/client-transcribe
        sudo npm install @aws-sdk/client-transcribe-streaming
        sudo npm install @aws-sdk/client-translate
      fi

      # clean
      clean_system
}


create_swap_and_edit_for_permanence()
{
      # create swap & make permanent at reboot
      sudo dd if=/dev/zero of=/swapfile count=2048 bs=1M
      sudo ls / | grep swapfile
      sudo chmod 600 /swapfile
      sudo ls -lh /swapfile
      sudo mkswap /swapfile
      sudo swapon /swapfile
      sudo free -m
      sudo scp /etc/fstab /etc/fstab.bak 
      echo '/swapfile none swap sw 0 0' >> /etc/fstab
      # set swapiness level & make permanent at reboot
      sudo scp /etc/sysctl.conf /etc/sysctl.conf.bak
      echo 'vm.swappiness=10' >> /etc/sysctl.conf
}


install_redis_stack_server () {
      cd /home/

      if [ $enable_redis_stack_server = true ]; then
        # install redis-stack-server latest version

        # 1. import the repository signing key:
        curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg
        
        # 2. create the file repository configuration:
        echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list
        
        # 3. update the package lists:
        sudo apt-get -y update

        # 4.  install
        sudo apt-get -y install redis-stack-server
        echo -e "Y"
        echo -e "Y"
        
        # 5. clean
        clean_system

        # 6. stop server
        sudo systemctl stop redis-stack-server

        # 7. create custom redis data dir and set permission on relevant dirs: data, run and log
        sudo chmod 777 /var/lib/redis-stack
        sudo mkdir $redis_data_dir
        sudo chmod 777 $redis_data_dir
        sudo chmod 777 /var/run
        sudo chmod 777 /var/log
        
        # 8. backup config file & create a custom config file: see READMEDatabaseConfig.txt in the repo for guide
        sudo scp /etc/redis-stack.conf /etc/redis-stack.bak

echo '# /etc/redis-stack.conf file 
# redis-stack.conf file
# customized by editing the settings below: remove, add or change settings as deem necessary

# NETWORK               
bind * -::*     
port 6379

# TLS/SSL
port 0
tls-port 6379
tls-ca-cert-file /etc/ssl/certs/root.crt
tls-cert-file /etc/ssl/certs/server.crt
tls-key-file /etc/ssl/certs/server.key
tls-client-cert-file /etc/ssl/certs/client.crt
tls-client-key-file /etc/ssl/certs/client.key
tls-auth-clients yes
tls-replication yes
tls-protocols "TLSv1.2 TLSv1.3"

# MODULES
loadmodule /opt/redis-stack/lib/redisearch.so
loadmodule /opt/redis-stack/lib/redisgraph.so
loadmodule /opt/redis-stack/lib/redistimeseries.so RETENTION_POLICY 0 OSS_GLOBAL_PASSWORD <master-password>
loadmodule /opt/redis-stack/lib/rejson.so
loadmodule /opt/redis-stack/lib/redisbloom.so

# GENERAL
daemonize no
databases 20
always-show-logo yes
pidfile /var/run/redis.pid
logfile /var/log/edis.log


# SNAPSHOTTING
stop-writes-on-bgsave-error no
# dir value below is the dir created in the start-up script
dir /var/lib/redis-stack/data  
dbfilename dump.rdb

# REPLICATION - set only on replica
# - set up on replica instance(s), if replication is desired
# replicaof <masterip> <masterport>
# masterauth <master-password>
# masteruser <username>

# SECURITY
requirepass <master-password>

# APPEND ONLY MODE
appendonly yes              
appendfsync always   
appendfilename appendonly.aof
appenddirname appendonlydir  

# REDIS CLUSTER - set up only for sharding (horizontal scaling)
# See: https://redis.io/docs/management/scaling/ for all settings
# cluster-enabled yes
# cluster-replica-validity-factor 0 

' > /etc/redis-stack.conf

sudo chmod 777 /etc/redis-stack.conf
      # 8. generate self-signed tls certs (server & client) for testing tls 
      # server
      sudo openssl genrsa -out /etc/ssl/certs/root.key 2048
      sudo openssl req -x509 -new -nodes -key /etc/ssl/certs/root.key -days 7300 -out /etc/ssl/certs/root.crt -subj '/CN=CAlocalhost'
      sudo openssl genrsa -out /etc/ssl/certs/server.key  2048 
      sudo openssl req -new -key /etc/ssl/certs/server.key -out /etc/ssl/certs/server.csr -subj '/CN=localhost'
      sudo openssl x509 -req -days 7300 -in /etc/ssl/certs/server.csr -CA /etc/ssl/certs/root.crt  -CAkey /etc/ssl/certs/root.key -set_serial 01 -out /etc/ssl/certs/server.crt 
      # client
      sudo scp /etc/ssl/certs/server.key /etc/ssl/certs/client.key
      sudo scp /etc/ssl/certs/server.crt /etc/ssl/certs/client.crt
      # set permission
      sudo chmod 775 /etc/ssl/certs/server.crt
      sudo chmod 775 /etc/ssl/certs/server.key
      sudo chmod 775 /etc/ssl/certs/root.crt
      sudo chmod 775 /etc/ssl/certs/client.crt
      sudo chmod 775 /etc/ssl/certs/client.key
      
      # 9. enable service and start, stop and restart server to enable all config settings
      sudo systemctl enable redis-stack-server.service
      sudo systemctl start redis-stack-server
      sudo systemctl stop redis-stack-server
      sudo systemctl start redis-stack-server

      fi
}


main () {
      create_dir_and_install_missing_packages
      install_and_configure_nodejs_web_server
      create_swap_and_edit_for_permanence
      install_redis_stack_server
}

main
