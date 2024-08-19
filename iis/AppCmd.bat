REM Create Application Pool
REM Path to APPCMD: c:\windows\system32\inetsrv\

@REM Replace {DomainName} with your domain name, {ServerName} with
@REM the name of the web content server, and {ContentShare} with the UNC share name of the content
@REM share on the content server.

Appcmd add AppPool 
  -name:Pool_Site%1 ^
  -processModel.username:{DomainName}\PoolId%1 ^
  -processModel.password:PoolIDPwd%1 ^
  -processModel.identityType:SpecificUser

REM Creating a site with the content, freb and log
REM configuration entries set to the directories we created and
REM secured before.
AppCmd add site ^
 -name:Site%1 ^
 -bindings:http/*:80:Site%1 ^
 -physicalPath:\\{ServerName}\{ContentShare}\Site%1\wwwroot ^
 -logfile.directory:\\{ServerName}\{ContentShare}\Site%1\logs\logfiles ^
 -traceFailedRequestsLogging.directory:\\{ServerName}\
 {--}\Site%1\logs\failedReqLogfiles

REM Now assign the root application of the newly created web-site
REM to its Application Pool
Appcmd set app ^
 -app.name:"Site%1/" ^
 -applicationPool:Pool_Site%1

