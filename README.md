# UNERED-Stack-On-AWS-Lightsail-with-AWS-SDK-JS

<br>
<strong>
Deploys Ubuntu, NodeJS, ExpressJS and Redis-Stack (UNEREDS) Stack on AWS Lightsail with AWS SDK for JavaScript/NodeJS V2.
</strong>
<br><br>
The  script deploys/creates or deletes the following specific resources and software:

1) AWS Lightsail instance(s) with Ubuntu 20.04 LTS OS
                                                                                                                                                 
2) Bash launch or start-up script (user data) for the installation of software, on the instance(s), including:

   -  Additional Ubuntu OS Packages <br>
   -  NodeJS <br>
   -  ExpressJS Web Server Framework <br>
   -  Other Node.js Packages and <br>
   -  Redis-Stack


## DEPLOYING STACK with the NodeJS script

### To deploy the stack  on ```AWS```, follow these steps:

1) #### Install NodeJS and aws-sdk (v2) module, assuming Ubuntu OS
    curl -fsSL https://deb.nodesource.com/setup_19.x | sudo -E bash - <br>
    sudo apt-get install -y nodejs <br>
    sudo npm install aws-sdk
    
2) #### Download or clone the following files, from this repo, into the current working directory (CWD): <br>
   NodeJS script - index.js <br>
   User data bash script (launch script)  - user-data.sh <br>
   JSON files  - credentials.json and inputConfig.json <br>

3) #### Fill in relevant values in the credentials.json and inputConfig.json files.<br>

4) #### Then run the code, assuming sudo access: <br>
   sudo node index.js


# License

Copyright © 2015 - present. MongoExpUser

Licensed under the MIT license.
