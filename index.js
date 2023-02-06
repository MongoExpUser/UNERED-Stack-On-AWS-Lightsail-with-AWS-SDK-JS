/*
#  *****************************************************************************************************************************************************
#  *                                                                                                                                                   *
#  * @License Starts                                                                                                                                   *
#  *                                                                                                                                                   *
#  * Copyright © 2015 - present. MongoExpUser.  All Rights Reserved.                                                                                   *
#  *                                                                                                                                                   *
#  * License: MIT - https://github.com/MongoExpUser/UNERED-Stack-On-AWS-Lightsail-with-AWS-SDK-JS/blob/main/LICENSE                                    *
#  *                                                                                                                                                   *
#  * @License Ends                                                                                                                                     *
#  *****************************************************************************************************************************************************
#  *                                                                                                                                                   *
#  *  index.js implements a module/script for the deploying/creating or deleting of resources, including:                                              *
#  *                                                                                                                                                   *
#  *  1) AWS Light instance(s) with Ubuntu OS -  20.04 LTS (ami-08d4ac5b634553e16)                                                                     *
#  *                                                                                                                                                   *
#  *  2) Bash launch/start-up script (user data) for the installation of software, on the instance(s), including:                                      *
#  *     Additional Ubuntu OS packages; NodeJS; ExpressJS web server framework; other Node.js packages; and PostgreSQL.                                *
#  *                                                                                                                                                   * 
#  *****************************************************************************************************************************************************
*/


class UNEPOStack
{
    constructor()
    {
      return null;
    }
    
    prettyPrint(value)
    {
        const util = require('util');
        console.log(util.inspect(value, { showHidden: true, colors: true, depth: 4 }));
    }
    
    confirmationMessage(error, data, message, line)
    {
        if(error)
        {
            return console.log(error);
        }
            
        const ups = new UNEPOStack();                 
        ups.prettyPrint(data);
        
        line;
        ups.prettyPrint(message);
        line;
        console.log(`Time is:`, new Date(), `.....`);
        line;
    }
            
    uuid4()
    {
        let timeNow = new Date().getTime();
        let uuidValue =  'xxxxxxxx-xxxx-7xxx-kxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(constant)
        {
            let random = (timeNow  + Math.random() *16 ) % 16 | 0;
            timeNow  = Math.floor(timeNow / 16);
            return (constant === 'x' ? random : (random & 0x3| 0x8)).toString(16);
        });
        
        return uuidValue;
    }
  
    createOrDelete(paramsObject=null)
    {
        const ups = new UNEPOStack();
        const Lightsail = require('aws-sdk/clients/lightsail');
        let options =  paramsObject.credentials;
        const lightsailClient = new Lightsail(options=options);
        const createInstancesParams = paramsObject.createParameters;
        const deleteInstanceParameters = paramsObject.deleteInstanceParameters;
        const deleteStaticIpParameters = paramsObject.deleteStaticIpParameters;
        const delayValueMilliSecond = paramsObject.delayValueMilliSecond;
        const portInfos = paramsObject.portInfos;
        const portInfosLength = portInfos.length;
        const line = UNEPOStack.separator();
        let createInstancesData;
   
        if(paramsObject.createResources === true)
        {
            // 1. create/allocate ip
            const allocateStaticIpParams = {
              staticIpName: paramsObject.staticIpName
            };
          
            lightsailClient.allocateStaticIp(allocateStaticIpParams, function(allocateStaticIpErrors, allocateStaticIpData)
            {
                const message = "Successfully created/allocate static ip";
                ups.confirmationMessage(allocateStaticIpErrors, allocateStaticIpData, message, line);


                // 2. create instance
                lightsailClient.createInstances(createInstancesParams, function(createInstancesError,  createInstancesData)
                {
                    const message = "Successfully created AWS Lightsail instance.";
                    ups.confirmationMessage(createInstancesError, createInstancesData, message, line);
                    
                    
                    // 3. attach static ip
                    const attachStaticIpParams = {
                      instanceName:  createInstancesData.operations[0].resourceName,
                      staticIpName: paramsObject.staticIpName
                    };
                    
                    // delay to allow instance to be fully created, before attaching static ip to the instance and setting firewall rules
                    console.log(`Delay for ${delayValueMilliSecond/1000} seconds before attaching static ip to Lightsail instance.`);
                  
                    setTimeout(function()
                    {
                        lightsailClient.attachStaticIp(attachStaticIpParams, function(attachStaticIpError,  attachStaticIpData)
                        {
                            const message = "Successfully attached static ip to AWS Lightsail instance.";
                            ups.confirmationMessage(attachStaticIpError,  attachStaticIpData, message, line);


                            // 4. open public ports i.e. set firewall rules for the instance
                            for(let index = 0; index < portInfosLength; index++)
                            {
                                const openInstancePublicPortsParams = {
                                    instanceName: createInstancesData.operations[0].resourceName,
                                    portInfo: portInfos[index]
                                };

                                lightsailClient.openInstancePublicPorts(openInstancePublicPortsParams, function(openInstancePublicPortsError, openInstancePublicPortsData) 
                                {
                                    const message = `Successfully open ports ${portInfos[index].fromPort} on AWS Lightsail instance.`;
                                    ups.confirmationMessage(openInstancePublicPortsError, openInstancePublicPortsData, message, line);
                                });
                            }

                        });
                        
                    }, delayValueMilliSecond);
                });
            });
        }
        else if(paramsObject.deleteResources === true)
        {
            // 4. delete instance
            lightsailClient.deleteInstance(deleteInstanceParameters, function(deleteInstanceError, deleteInstanceData)
            {
                  
                  const message = "Successfully deleted AWS Lightsail instance.";
                  ups.confirmationMessage(deleteInstanceError, deleteInstanceData, message, line);
                    
                  lightsailClient.releaseStaticIp(deleteStaticIpParameters, function(deleteStaticIpError, deleteStaticIpData)
                  {
                      const message = "Successfully deleted Lightsail static ip.";
                      ups.confirmationMessage(deleteStaticIpError, deleteStaticIpData, message, line);
                });
            });
        }
    }
    
    getUNEPOUserData(userDataFilePath, fs)
    {
        return fs.readFileSync(userDataFilePath,  { encoding: "utf-8"} ); // read in with utf-8 encoding
    }

    static separator()
    {
      console.log(`---------------------------------------------------------------------------------`);
    }
}


(function main()
{

    // require/import and instantiate relevant modules
    const fs = require('fs');
    const ups = new UNEPOStack();
    const inputConfigJsonFilePath = "inputConfig.json";
    let inputConfig = JSON.parse(fs.readFileSync(inputConfigJsonFilePath));
    const numberOfInstance = inputConfig.numberOfInstance;


    for(let indexValue = 0; indexValue < numberOfInstance; indexValue++)
    {
        // read config, user-data and credentials files into variables
        inputConfig =  JSON.parse(fs.readFileSync(inputConfigJsonFilePath)); // re-read/re-load to ensure uniqueness
        const userDataFilePath = inputConfig.userData;
        const credentialJsonFilePath = inputConfig.credentials;
        const credentials =  JSON.parse(fs.readFileSync(credentialJsonFilePath));
        // define common naming, tagging and environmental variables
        const addSuffix = inputConfig.addSuffix;
        const uuid4 =  ups.uuid4();
        const suffix = String(uuid4).substring(0, 3);
        const orgName = inputConfig.orgName;
        const projectName = inputConfig.projectName;
        const environment  = inputConfig.environment;
        const regionName = inputConfig.regionName;
        const preOrPostFix = `${orgName}-${environment}`;
        const resourceName = inputConfig.createParameters.instanceNames[0];
        const serviceProvider = inputConfig.serviceProvider;
        const creator = inputConfig.creator;
        const nodejsVersion = inputConfig.nodejsVersion;
        const redisStackVersion = inputConfig.redisStackVersion;
        const staticIpName = inputConfig.staticIpName;
        const tags = [
          { key: "region", value: regionName },
          { key: "environment", value:  environment },
          { key: "project", value:  projectName },
          { key: "creator", value:  creator },
          { key: "service-provider", value:  serviceProvider },
          { key: "nodejs-version", value:  nodejsVersion  },
          { key: "redis-stack-version", value:  redisStackVersion }
        ];
        
        //add naming tags with uuid-generared substring suffix for uniqueness
        if(addSuffix === true)
        {
          tags.push( { key: "name", value: `${preOrPostFix}-${resourceName}-${suffix}` } );
        }
        else if(addSuffix === false)
        {
          tags.push( { key: "name", value: `${preOrPostFix}-${resourceName}` } );
        }
        
        //define parameters
        const paramsObject = {
            credentials : credentials,
            createParameters : inputConfig.createParameters,
            deleteInstanceParameters : inputConfig.deleteInstanceParameters,
            deleteStaticIpParameters : inputConfig.deleteStaticIpParameters,
            createResources : inputConfig.createResources,
            deleteResources : inputConfig.deleteResources,
            delayValueMilliSecond : inputConfig.delayValueMilliSecond,
            portInfos : inputConfig.portInfos
        }
        
        try
        {
            //add "userData" and "tags" to the "createParameters" variable on the "paramsObject" object.
            paramsObject.createParameters.userData = ups.getUNEPOUserData(userDataFilePath, fs);
            paramsObject.createParameters.tags = tags;
            let numberOfInstance = paramsObject.createParameters.instanceNames.length;
            // make "instance name" and "static ip" Name unique
            let name = paramsObject.createParameters.instanceNames[0];
            paramsObject.createParameters.instanceNames[0] = (`${preOrPostFix}-${name}-${suffix}`);
            paramsObject.staticIpName = `${preOrPostFix}-${staticIpName}-${suffix}`;
 
            //finally, CREATE instance  and static ip; and install software or DELETE instance and static ip
            ups.createOrDelete(paramsObject);
        }
        catch (error)
        {
            return console.log("Error", error);
        }
    }
}());
