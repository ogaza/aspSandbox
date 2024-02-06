<%
Dim wswebsitename : wswebsitename = "aspSandBox"
' Dim wswebsitename : wswebsitename = VERRA-WS-DEV01
Dim server_ : server_ = "localhost"
' Dim server = emregqa-usw-app

' Dim vhost
Dim vhost : Set vhost = Server.CreateObject("SQLVDir.SQLVDirControl")
' Dim vhost : Set vhost = Server.CreateObject("SQLVDir.SQLVDirControl.3.0")

' vhost.Connect server, vhostId
' vhost.Disconnect

Set vhost = Nothing

Response.Write(server_)

%>

<%

Function GetSiteID(SiteName )
    Set objWebService = GetObject( "IIS://localhost/W3SVC" )

    Dim objWebServer, objWebServerRoot, strBindings

    GetSiteID = 0
    FOR EACH objWebServer IN objWebService
        IF objWebserver.Class = "IIsWebServer" THEN
        SET objWebServerRoot = GetObject(objWebServer.adspath & "/root")
            
		if (SiteName  = objWebServer.ServerComment) THEN
			GetSiteID = objWebserver.Name
			Exit FUNCTION
		End if
        END IF
    NEXT

End Function 

%>