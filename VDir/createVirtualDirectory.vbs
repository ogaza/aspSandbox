Dim vdirName : vdirName = "VCSA"
Dim soapName : soapName = "VCSA_SOAP"

Dim server : server = "LT-OGAZA"
' Dim server : server = "localhost"
Dim wswebsitename : wswebsitename = "sqlXmlSandbox"
Dim vhostId : vhostId = GetSiteID(wswebsitename)

WScript.Echo "sqlXmlSandbox's site id"
WScript.Echo vhostId

Dim path : path = "C:\Inetpub\sqlXmlSandbox" '"C:\Inetpub\VERRA-WS-DEV01"
Dim userName : userName = "verra-webappuser" 'config("userName")
Dim password : password = "!apx52" 'config("password")
Dim dbHost : dbHost = "emregqa-usw-db4" 'config("dbHost")
Dim secondaryDbHost : secondaryDbHost = "emregqa-usw-db4" 'config("secondaryDbHost")
Dim currentDbHost : currentDbHost = dbHost
Dim dbName : dbName = "VERRA-APP-DEV01" 'config("dbName")

Dim vhost : Set vhost = CreateObject("SQLVDir.SQLVDirControl.3.0")

WScript.Echo "Connecting"
vhost.Connect "winserv2012"
' vhost.Connect "winserv2012", vhostId
' vhost.Connect "localhost", vhostId
' vhost.Connect "LT-OGAZA", vhostId
' vhost.Connect "IISServer", vhostId
' vhost.Connect server, vhostId
' vhost.Connect ', vhostId


WScript.Echo "Disconnect"
vhost.Disconnect
Set vhost = Nothing


Function GetSiteID(siteName)
  GetSiteID = 0
  ' WScript.Echo "Get WebService: IIS://localhost/W3SVC"
  Dim objWebService
  Set objWebService = GetObject( "IIS://localhost/W3SVC")

  Dim objWebServer ', objWebServerRoot, strBindings
  ' 
  ' WScript.Echo "Iterate WebService"
  For Each objWebServer In objWebService
    If objWebserver.Class = "IIsWebServer" Then

      ' WScript.Echo "Site"
      ' WScript.Echo objWebServer.ServerComment
      ' WScript.Echo "Site Id:"
      ' WScript.Echo objWebserver.Name

      ' Set objWebServerRoot = GetObject(objWebServer.adspath & "/root")
          
      If (siteName  = objWebServer.ServerComment) Then
        GetSiteID = objWebserver.Name
        Exit Function
      End if
    End IF
  Next
End Function