#!/bin/bash

#======================================================================================================================#
#                                                                                                                      #
#  @License Starts                                                                                                     #
#                                                                                                                      #
#  Copyright © 2015 - present. MongoExpUser.  All Rights Reserved.                                                     #
#                                                                                                                      #
#  License: MIT - https://github.com/MongoExpUser/UNERED-Stack-On-AWS-Lightsail-with-AWS-SDK-JS/blob/main/LICENSE.     #
#                                                                                                                      #
#  @License Ends                                                                                                       #
#                                                                                                                      #
#......................................................................................................................#
#                                                                                                                      #
#  user-data.sh (lauch/start-up script) - performs the following actions:                                              #
#  1) Installs additional Ubuntu packages                                                                              #
#  2) Installs and configures Node.js v19.x and Express v5.0.0-alpha.8 web server framework                            #
#     Installs other node.js packages                                                                                  #
#  3) Installs redis-stack server                                                                                      #
#                                                                                                                      #
#======================================================================================================================#


sudo chmod 775 /home
sudo chmod 775 /home/ubuntu
      
# define common variable(s)
base_dir="base"
server_dir="server"
client_dir="client"
enable_web_server=true
enable_postgresql_server=true


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
      # create relevant directories
      cd /home/
      sudo mkdir $base_dir
      cd $base_dir
      sudo mkdir $server_dir
      sudo mkdir $client_dir
          
          
      # install additional packages (in case not available in the base image)
      sudo apt-get -y install sshpass
      echo -e "Y"
      echo -e "Y"
      sudo apt-get -y install cmdtest
      echo -e "Y"
      echo -e "Y"
      sudo apt-get -y install spamassassin
      echo -e "Y"
      echo -e "Y"
      sudo apt-get -y install snap
      echo -e "Y"
      echo -e "Y"
      sudo apt-get -y install nmap
      echo -e "Y"
      echo -e "Y"
      sudo apt-get -y install net-tools
      echo -e "Y"
      echo -e "Y"
      sudo apt-get -y install aptitude
      echo -e "Y"
      echo -e "Y"
      sudo apt-get -y install build-essential
      echo -e "Y"
      echo -e "Y"
      sudo apt-get -y install certbot
      echo -e "Y"
      echo -e "Y"
      sudo apt-get -y install python3-certbot-apache
      echo -e "Y"
      echo -e "Y"
      sudo apt-get -y install systemd
      echo -e "Y"
      echo -e "Y"
      sudo apt-get -y install procps
      echo -e "Y"
      echo -e "Y"
      sudo apt-get -y install nano
      echo -e "Y"
      echo -e "Y"
      sudo apt-get -y install apt-utils
      echo -e "Y"
      echo -e "Y"
      sudo apt-get -y install wget
      echo -e "Y"
      echo -e "Y"
      sudo apt-get -y install curl
      echo -e "Y"
      echo -e "Y"
      sudo apt-get -y install gcc
      echo -e "Y"
      echo -e "Y"
      sudo apt-get -y install gnupg
      echo -e "Y"
      echo -e "Y"
      sudo apt-get -y install gnupg2
      echo -e "Y"
      echo -e "Y"
      sudo apt-get -y install make
      echo -e "Y"
      echo -e "Y"
      sudo apt-get -y install sshpass
      echo -e "Y"
      echo -e "Y"
      sudo apt-get -y install cmdtest
      echo -e "Y"
      echo -e "Y"
      sudo apt-get -y install snapd
      echo -e "Y"
      echo -e "Y"
      sudo apt-get -y install screen
      echo -e "Y"
      echo -e "Y"
      sudo apt-get -y install spamc
      echo -e "Y"
      echo -e "Y"
      sudo apt-get -y install parted
      echo -e "Y"
      echo -e "Y"
      sudo apt-get -y install iputils-ping
      echo -e "Y"
      echo -e "Y"
      sudo apt-get -y install unzip
      echo -e "Y"
      echo -e "Y"
      sudo apt-get -y install gzip
      echo -e "Y"
      echo -e "Y"
      sudo apt-get -y install xfsprogs
      echo -e "Y"
      echo -e "Y"
      sudo modprobe -v xfs
     
      # aws cli (version 2)
      sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
      echo -e "Y"
      echo -e "Y"
      sudo chmod 777 awscliv2.zip
      sudo unzip awscliv2.zip
      echo -e "Y"
      echo -e "Y"
      sudo ./aws/install
      
      #  python 3.x
      sudo apt-get -y install python3
      echo -e "Y"
      echo -e "Y"

      # clean
      clean_system
}


install_and_configure_nodejs_web_server () {
      cd /home/
      cd $base_dir
      
      if [ $enable_web_server = true ]
      then
        # install node.js - version 19
        curl -sL https://deb.nodesource.com/setup_19.x | sudo -E bash -
        echo -e "\n"
        sudo apt-get install -y nodejs
        echo -e "\n"
            
        # create node.js' package.json file
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
            "PostgreSQL\""
          ]
        }' > package.json
        # a. all modules (except aws modules)
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
        # b. other db drivers
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

    
install_redis_stack_server () {

      if [ $enable_postgresql_server = true ]
      then
       # install redis-stack-server latest version
        # 1. import the repository signing key:
        curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg
        # 2. create the file repository configuration:
        echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list
        # 3. update the package lists:
        sudo apt-get -y update
        # 4.  finally, install
        sudo apt-get -y install redis-stack-server
        echo -e "Y"
        echo -e "Y"
        
        # 5. clean
        clean_system

        # by default, redis-server auto starts after installation
        
        # To START or Re-START or STOP Redis-stack Server or Check Status of Redis-stack Server, use these commands:
        # sudo systemctl start redis-stack-server
        # sudo systemctl restart redis-stack-server
        # sudo systemctl stop redis-stack-server
        # sudo systemctl status redis-stack-server
        
        # To list current active redis units, use this command
        # sudo systemctl list-units | grep redis
        
        # to connect to Redis-stack server via the command line/cli/shell use this command:
        # sudo redis-cli
        
        # FOR PRODUCTION deployment, edit configuration file, to ensure high security, high avalaibility, access control, etc. by:
        #  a) creating role(s)/user(s) with relevant level of permissions
        #  b) deploying server with tls/ssl (in-transit), and at-rest (disk/data) encryption
        #  c) using redis management document as guide:
        #     see link to redis documentation on admin, security, config, HA, replication, scaling, persistence, etc: https://redis.io/docs/management/
        #     path to configuration file on Ubuntu OS: sudo nano /etc/redis/redis.conf
        
        # ===========================
        # Recommended Node.js Client
        # ===========================
        # Node-redis
        # Documentation Link: https://github.com/redis/node-redis
        # Installation: sudo npm install redis
        
      fi
}


main () {
      # execute all functions sequentially
      create_dir_and_install_missing_packages
      install_and_configure_nodejs_web_server
      install_redis_stack_server
}


# invoke main
main
