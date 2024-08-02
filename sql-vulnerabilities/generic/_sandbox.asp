<title>_sandbox</title>
<!-- links to js and css shoul be at the top in order for them to be placed in the head by the browser-->
<!--<script src="index.js" defer type="module"></script> -->
<!-- end of links -->

<!-- includes for asp with code here -->

<!--#include virtual="/Auth/Services/ApxSecurity.inc.asp"-->
<!--#include virtual="/Auth/Services/Authservice.asp"-->
<!--#include virtual="/DB/iDBPointer.asp"-->
<!--#include virtual="/DB/iDB.asp"-->
<!--#include virtual="/sql-vulnerabilities/DAO/myLoginModule.asp"-->
<!--#include virtual="/sql-vulnerabilities/DAO/myMessages.asp"-->

<!-- end of asp includes -->

<!-- asp code here -->
<%
RedirectIfNotLoggedIn
%>
<!-- end of asp code-->

<!--#include virtual="/Views/Common/myPageHeader.asp"-->

<%
Dim TagDB
Set TagDB = Server.CreateObject("ADODB.Connection")
TagDB.Open(VerraLocalDatabase)

Dim result, m_iAccountHolderId

m_iAccountHolderId = 1

Dim bProgramValidation(2)
Dim bProgramVerification(2)
Dim iProgram(2)

bProgramValidation(0) = False
bProgramValidation(1) = False
bProgramValidation(2) = False

bProgramVerification(0) = True
bProgramVerification(1) = True
bProgramVerification(2) = True

iProgram(0) = 1
iProgram(1) = 2
iProgram(2) = 3

result = InsertProgramAuditor()

Response.Write("result: " & result & "</br>")

' Dim msgText
' Dim mType, from_Loginid, toid

' msgText = "with transaction"
' mType = "L"
' from_Loginid = CInt(Session("loginid"))
' toid = 1

' Response.Write("msgText: " & msgText & "</br>")
' Response.Write("mType: " & mType & "</br>")
' Response.Write("from_Loginid: " & from_Loginid & "</br>")
' Response.Write("toid: " & toid & "</br>")

' Dim messageInserted

' TagDB.beginTrans

' messageInserted = SendText(msgText, mType, from_Loginid, toid)

' If messageInserted = True Then
'   Response.Write("CommitTrans")
'   Response.Write("</br>")
'   TagDB.CommitTrans
' Else
'   TagDB.RollbackTrans
'   Response.Write("RollbackTrans")
'   Response.Write("</br>")
' End If

' message text
' Dim messageTextInserted, messageTextId
' messageTextInserted = SaveMessageText("test test test")

' If messageTextInserted Then
'   messageTextId = GetMessageTextId()
' End If

' Response.Write("messageTextInserted: "& messageTextInserted)
' Response.Write("</br>")
' Response.Write("messageTextId: "& messageTextId)
' Response.Write("</br>")

'-----------------------------------------------------------
' INSERT

' Dim mType, from_Loginid, toid, messageTextID

' mType = "L"
' from_Loginid = 1
' toid = 1
' messageTextID = 1

' Dim newInserted : newInserted = False

' TagDB.beginTrans
' newInserted = myMessages__insert(mType, from_Loginid, toid, messageTextID)
' newInserted = myMessages__insert(mType, "from_Loginid", toid, messageTextID)

' Response.Write("newInserted: "& newInserted)
' Response.Write("</br>")

' If newInserted Then
'   Response.Write("CommitTrans")
'   Response.Write("</br>")
'   TagDB.CommitTrans
' Else
'   Response.Write("RollbackTrans")
'   Response.Write("</br>")
'   TagDB.RollbackTrans
' End IF

'-----------------------------------------------------------

' Response.Write("</br>")
' Response.Write("</br>")

'-----------------------------------------------------------
' SELECT

' Dim id : id = 7
' Dim myMessage : Set myMessage = myMessages__select(id)

' Response.Write("id: " & id & "</br>")
' Response.Write("Message: " & myMessage.Message & "</br>")
' Response.Write("ReceiveDate: " & myMessage.ReceiveDate & "</br>")


' ============================================================================================
' myLoginModule

' Dim loginId : loginId = 7
' Dim loginName, orderBy, errorMsg
' Dim myLoginModules, myLoginModule


' READ ------------------------------------------------------------------------------------
' myLoginModules = myLoginModule__select(loginId, CStr(loginName), CStr(orderBy), errorMsg)

' For Each myLoginModule In myLoginModules
'   RenderMyLoginModule myLoginModule
' Next

' Response.Write("</br>")
' Response.Write("</br>")

' EDIT ------------------------------------------------------------------------------------
' Dim lModules, rModules
' Dim updateSuccessful
' lModules = "1,2"
' rModules = "4,5"

' updateSuccessful = myLoginModule__update(loginId, lModules, rModules, "", errorMsg)
' updateSuccessful = myLoginModule__update(loginId, null, rModules, null, errorMsg)

' Response.Write("updateSuccessful: " & updateSuccessful & "</br>")

' If (Not updateSuccessful) then
'   Response.Write("errorMsg: " & errorMsg & "</br>")
' Else
'   Response.Write("no errors </br>")
' End If

' READ ------------------------------------------------------------------------------------
' myLoginModules = myLoginModule__select(loginId, CStr(loginName), CStr(orderBy), errorMsg)

' For Each myLoginModule In myLoginModules
'   RenderMyLoginModule myLoginModule
' Next

TagDB.Close
%>

<%
Function InsertProgramAuditor()
  InsertProgramAuditor = False

  Dim oRs, accountTypeArray, iIndex
  Dim oCom, sSql, flag, isVal, isVer

  Dim progIsVal
  Dim progIsVer

  For iIndex = LBound(bProgramValidation) To UBound(bProgramValidation)
    If bProgramValidation(iIndex) = True Or bProgramVerification(iIndex) = True Then

      If bProgramValidation(iIndex) Then
          isVal = 1
      Else
          isVal = 0
      End If
      progIsVal = progIsVal & iProgram(iIndex) & "," & isVal

      If bProgramVerification(iIndex) Then
          isVer = 1
      Else
          isVer = 0
      End If

      progIsVer = progIsVer & iProgram(iIndex) & "," & isVer 

      If iIndex <> UBound(bProgramValidation) Then
        progIsVer = progIsVer & ";"
        progIsVal = progIsVal & ";"
      End If

    End If
  Next

  Response.Write("progIsVal: " & progIsVal & "</br>")
  Response.Write("progIsVer: " & progIsVer & "</br>")


  sSql = _
  "DECLARE @ahId INT = ?; " &_
  "DECLARE @progIsVal VARCHAR(255) = ?; " &_
  "DECLARE @progIsVer VARCHAR(255) = ?; " &_
  "DECLARE @isValRows TABLE (row Varchar(50)); " &_
  "DECLARE @progIsValTab TABLE (prog Varchar(50), isVal Varchar(50)); " &_
  "DECLARE @isVerRows TABLE (row Varchar(50)); " &_
  "DECLARE @progIsVerTab TABLE (prog Varchar(50), isVer Varchar(50)); " &_
  "INSERT INTO " &_
  "  @IsValRows " &_
  "  SELECT " &_
  "    * " &_
  "  FROM string_split(@progIsVal,';') " &_
  "INSERT INTO @progIsValTab " &_
  "SELECT " &_
  "  SUBSTRING(row, 1,  CHARINDEX(',', row) - 1), " &_
  "  SUBSTRING(row, CHARINDEX(',', row) + 1, LEN(row) - CHARINDEX(',', row)) " &_
  "FROM " &_
  "  @isValRows " &_
  "INSERT INTO " &_
  "  @isVerRows " &_
  "  SELECT " &_
  "    * " &_
  "  FROM string_split(@progIsVer,';') " &_
  "INSERT INTO @progIsVerTab " &_
  "SELECT " &_
  "  SUBSTRING(row, 1,  CHARINDEX(',', row) - 1), " &_
  "  SUBSTRING(row, CHARINDEX(',', row) + 1, LEN(row) - CHARINDEX(',', row)) " &_
  "FROM " &_
  "  @isVerRows " &_
  "DECLARE @programAuditor dbo.typeProgramAuditor; " &_
  "INSERT INTO " &_
  "  @programAuditor(ahId, programId, authorizedForInitialAudit, authorizedForOngoingAudit) " &_
  "SELECT  " &_
  "  @ahId, " &_
  "  val.prog, " &_
  "  val.isVal, " &_
  "  ver.isVer " &_
  "FROM " &_
  "  @progIsValTab val, @progIsVerTab ver " &_
  "WHERE " &_
  "  val.prog = ver.prog " &_
  "EXEC sp_InsertProgramAuditor @ahId, @programAuditor "

  ' Exit Function

  Set oCom = Server.CreateObject("ADODB.Command")
  oCom.CommandType = adCmdText
  oCom.ActiveConnection = TagDB
  oCom.CommandText = sSql

  oCom.Parameters.Append oCom.CreateParameter( , adInteger, adParamInput, , m_iAccountHolderId)
  oCom.Parameters.Append oCom.CreateParameter( , adVarChar, adParamInput, 255, progIsVal)
  oCom.Parameters.Append oCom.CreateParameter( , adVarChar, adParamInput, 255, progIsVer)

  On Error Resume Next
  oCom.Execute
  On Error GoTo 0
  If (TagDB.Errors.Count) Then
    ' errMsg = TagDB.Errors.Item(0).Description
    Response.Write("there has been a sql error </br>")
    Exit Function
  End If

  sSql = "SELECT * FROM ProgramAuditor"

  Set oCom = Server.CreateObject("ADODB.Command")
  oCom.CommandType = adCmdText
  oCom.ActiveConnection = TagDB
  oCom.CommandText = sSql

  Set oRs = oCom.Execute

  Dim ahId
  Dim programId
  Dim authorizedForInitialAudit
  Dim authorizedForOngoingAudit

  While Not oRs.EOF
    ahId = oRs.Fields.Item("ahId")
    programId = oRs.Fields.Item("programId")
    authorizedForInitialAudit = oRs.Fields.Item("authorizedForInitialAudit")
    authorizedForOngoingAudit = oRs.Fields.Item("authorizedForOngoingAudit")

    Response.Write(ahId & " | " & programId & " | " & authorizedForInitialAudit & " | " & authorizedForOngoingAudit)
    Response.Write("</br>")

    oRs.MoveNext
  Wend

  oRs.Close()
  Set oRs =  Nothing

  InsertProgramAuditor = True
End Function

Function UpdateUsingRecordSet()
  UpdateUsingRecordSet = False

  Dim serialNumberCode
  serialNumberCode = "VCS"
  
  Dim newSerialNumberCode
  newSerialNumberCode = "VCS"
  ' newSerialNumberCode = "Delete dbo.Program;"

  Dim programId : programId = 1

  'On Error Resume Next
  Dim sSql, oRs, oCom
  ' Call oRs.Open("SELECT * FROM recAccountHolder WHERE ahId = " & m_iAccountHolderId, TagDB, adOpenKeyset, adOpenDynamic)

  sSql = "SELECT * FROM dbo.Program WHERE programId = ? "

  Set oCom = Server.CreateObject("ADODB.Command")
  oCom.CommandType = adCmdText
  oCom.ActiveConnection = TagDB
  oCom.CommandText = sSql

  oCom.Parameters.Append oCom.CreateParameter( , adInteger, adParamInput, , programId)

  Set oRs = Server.CreateObject("ADODB.Recordset")
  On Error Resume Next
  oRs.Open oCom, , adOpenKeyset, adOpenDynamic 
  On Error GoTo 0


  If Not oRs.EOF Then 
    Dim existingSerialNumberCode
    existingSerialNumberCode = oRs.Fields.Item("serialNumberCode")
    Response.Write("existingSerialNumberCode: " & existingSerialNumberCode & "</br>")
  Else
    Response.Write("no resords </br>")
  End If

  oRs.Fields("serialNumberCode") = newSerialNumberCode
  oRs.Update()

  If (TagDB.Errors.Count) Then
    ' Call DisplaySqlError(sSql)
    ' m_sError = "UPDATE recAccountHolder: " & Err.Description
    ' oRs.Close()
    Set oRs = Nothing
    Exit Function
  Else
    UpdateUsingRecordSet = True
  End If

  oRs.Close()
  Set oRs = Nothing
End Function

Function SendText(msgText, mType, from_Loginid, toid)
  SendText = False

  Dim messageTextInserted, messageTextId
  messageTextInserted = SaveMessageText(msgText)

  If (messageTextInserted = False) Then
    Exit Function
  End If

  messageTextId = GetMessageTextId

  ' Response.Write("messageTextId: " & messageTextId & "</br>")
  ' Response.Write("messageTextId < 1: " & (messageTextId < 1) & "</br>")

  If messageTextId < 0 Then
    Exit Function
  End If

  Dim messageInserted
  messageInserted = myMessages__insert( _
    mType, from_Loginid, toid, messageTextId)

  ' Response.Write("messageInserted: " & messageInserted & "</br>")

  SendText = messageInserted
  
End Function

Function SaveMessageText(text)
  SaveMessageText = False

  Dim oCom, sSql, rs

  Set oCom = Server.CreateObject("ADODB.Command")
  oCom.ActiveConnection = TagDB
  oCom.CommandText = "Insert into myMessageText(messageText) values(?)"

  oCom.Parameters(0) = Left(text, 2000)

  Dim rowsAffected : rowsAffected = 0
  On Error Resume Next
  oCom.Execute rowsAffected
  If (TagDB.Errors.Count) Then
    call DisplaySqlError(sql)
    ' rs.close
    ' set rs = nothing
    Exit Function
  End If

  SaveMessageText = rowsAffected > 0
End Function

Function GetMessageTextId()
  GetMessageTextId = -1

  Dim sql, oRs
  sql = "select @@identity"
  Set oRs = TagDB.Execute(sql)

  If (TagDB.Errors.Count) Then
    call DisplaySqlError(sql)
    set oRs = nothing
    Exit Function
  End If

  If Not oRs.EOF Then
    GetMessageTextId = CInt(oRs.Fields(0))

    ' Response.Write("DEBUG </br>")
    ' Response.Write("GetMessageTextId: " & GetMessageTextId)
    oRs.close
  End if
  set oRs = nothing
End Function

%>

<%
Sub RenderMyLoginModule(myLoginModule)
  Response.Write("LoginId: " & myLoginModule.LoginId & "</br>")
  Response.Write("LoginName: " & myLoginModule.LoginName & "</br>")
  Response.Write("LModules: " & myLoginModule.LModules & "</br>")
  Response.Write("RModules: " & myLoginModule.RModules & "</br>")
  Response.Write("MarketType: " & myLoginModule.MarketType & "</br>")
End Sub
%>
