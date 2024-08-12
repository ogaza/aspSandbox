SETLOCAL 
REM Save command-line arguments passed as parameters: 
SET SITE_ID=%1% 
SET CONTENT_ROOT=%2 

md %CONTENT_ROOT%\site%SITE_ID% 
md %CONTENT_ROOT%\site%SITE_ID%\logs 
REM ACL SITE DIRECTORY FOR ADMINS AND the APPPOOL ACCOUNT 
icacls %CONTENT_ROOT%\site%SITE_ID% /G {DomainName}\PoolId%1:R /y 
icacls %CONTENT_ROOT%\site%SITE_ID% /E /G Administrators:F 

REM CREATING FAILED REQUEST LOG DIRECTORY 
md %CONTENT_ROOT%\site%SITE_ID%\logs\failedReqLogfiles 
icacls %CONTENT_ROOT%\site%SITE_ID%\logs\failedReqLogfiles /G {DomainName}\PoolId%1:F /y 
icacls %CONTENT_ROOT%\site%SITE_ID%\logs\failedReqLogfiles /E /G Administrators:F 

REM CREATING WEBLOG DIRECTORY. HTTP.SYS LOGS AS MACHINE IDENTITY 
md %CONTENT_ROOT%\site%SITE_ID%\logs\logfiles 
icacls %CONTENT_ROOT%\site%SITE_ID%\logs\logfiles /G {DomainName}\{MachineIdentity}:F /y 
icacls %CONTENT_ROOT%\site%SITE_ID%\logs\logfiles /E /G Administrators:F 

REM CREATING WEB CONTENT DIRECTORY 
md %CONTENT_ROOT%\site%SITE_ID%\wwwroot 
icacls %CONTENT_ROOT%\site%SITE_ID%\wwwroot /G {DomainName}\PoolId%1:F /y 
icacls %CONTENT_ROOT%\site%SITE_ID%\wwwroot /E /G Administrators:F