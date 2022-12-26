
READMEDatabaseConfig.txt

================================
# README Database Configuration
================================

# By default, redis-server auto starts after installation
        
# To START or Re-START or STOP Redis-stack Server or Check Status of Redis-stack Server, use these commands:
# sudo systemctl start redis-stack-server
# sudo systemctl restart redis-stack-server
# sudo systemctl stop redis-stack-server
# sudo systemctl status redis-stack-server
        

# To list current active redis units, use this command
# sudo systemctl list-units | grep redis


# To connect to Redis-stack server via the command line/shell, use any of these commands:
# sudo redis-cli
# sudo redis-cli -h host -p port 
# -- with tls configured, see next line
# sudo redis-cli -h host -p port --tls --cert /etc/ssl/certs/server.crt --key /etc/ssl/certs/server.key --cacert /etc/ssl/certs/root.crt 


# Then authenticate with the following command, if the server is configured for authentication (i.e. requirepass is  enabled)
# auth username password  
# note 1: username is "default" or any "other" username created on the server
# note 2: if no username is specified (i.e auth password), the "default" username is assumed


# Check REPLICATION status on primary (master) and replica after authenticating, use this command:
# INFO REPLICATION


# Check CLUSTER status on primary (master) and replica after authenticating, use this command:
# INFO CLUSTER


# Check general INFO on primary (master) and replica after authenticating, use this command:
# INFO
# These include information on: server, clients, memory, persistence, stats, replication, CPU, modules, error stats, cluster & keyspace

        
# FOR PRODUCTION deployment, edit configuration file, to ensure high security, high availability, access control, etc. by:
#  a) Creating role(s)/user(s) with relevant level of permissions
#  b) Deploying server with tls/ssl (in-transit), and at-rest (disk/data) encryption
#  c) Using redis management document as guide:
#     - See link to redis documentation on admin, security, config, HA, replication, scaling, persistence, etc: 
        https://redis.io/docs/management/
#     - Path to configuration file on Ubuntu OS: sudo nano /etc/redis-stack.conf
#     - Configuration file samples:
#        -- https://raw.githubusercontent.com/redis/redis/7.0/redis.conf
#        -- https://redis.io/docs/management/config-file/
#     - Can also set indvidual config file entry via redis-cli with : CONFIG SET - see https://redis.io/commands/config-set/
#     - List all config file entries via redis cli with : CONFIG GET *   - see https://redis.io/commands/config-get/
#     - Get default data directory: GET CONFIG DIR 
        

# ===========================
# Recommended Node.js Client
# ===========================
# Node-redis
# Documentation Link: https://github.com/redis/node-redis
# Installation: sudo npm install redis
