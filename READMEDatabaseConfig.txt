
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
        
# To connect to Redis-stack server via the command line/cli/shell use this command:
# sudo redis-cli
        
# FOR PRODUCTION deployment, edit configuration file, to ensure high security, high avalaibility, access control, etc. by:
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
        
# ===========================
# Recommended Node.js Client
# ===========================
# Node-redis
# Documentation Link: https://github.com/redis/node-redis
# Installation: sudo npm install redis
# for documentation of all options, see:
