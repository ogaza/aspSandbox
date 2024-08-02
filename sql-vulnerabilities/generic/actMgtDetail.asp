<title>actMgtDetail sandbox</title>
<!-- links to js and css shoul be at the top in order for them to be placed in the head by the browser-->
<!--<script src="index.js" defer type="module"></script> -->
<!-- end of links -->

<!-- includes for asp with code here -->

<!--#include virtual="/Auth/Services/ApxSecurity.inc.asp"-->
<!--#include virtual="/Auth/Services/Authservice.asp"-->
<!--#include virtual="/DB/iDBPointer.asp"-->
<!--#include virtual="/DB/iDB.asp"-->
<!--#include virtual="/sql-vulnerabilities/DAO/myLogins.asp"-->

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

mylogins__selectHavingRecLogins  1, 1, 1, ""

' Dim result 
' result = myLoginPrivileges__insert(2, True, True, True)
' Response.Write("myLoginPrivileges__insert result: " & result & "</br>")

' Dim result 
' result = RecLogin__insert(1,1)
' Response.Write("RecLogin__insert result: " & result & "</br>")

' RecAddressInfo__delete(3)

' Dim loginUpdated
' loginUpdated = updateMylogin()
' Response.Write("loginUpdated: " & loginUpdated & "</br>")

' Dim address_id, addr1, addr2, city, state, zip, country, tel, fax, email, url
' address_id = 1
' addr1 = "111" 
' addr2 = "" 
' city = ""
' state = ""
' zip= "" 
' country = "" 
' tel = ""
' fax="" 
' email = ""
' url = ""

' UpdateAddressInfo address_id, addr1, addr2, city, state, zip, country, tel, fax, email, url

TagDB.Close
%>

<%
Const LOGIN_STATUS_PENDING    = 1
Const LOGIN_STATUS_APPROVED    = 2
Const LOGIN_STATUS_REJECTED    = 3

Function updateMylogin()
  Dim sSql
  sSql = _
  "DECLARE @email nvarchar(255) = ?; " & vbcrlf &_
  "DECLARE @cellphone varchar(32) = ?; " & vbcrlf &_
  "DECLARE @Active bit = ?; " & vbcrlf &_
  "DECLARE @PrivilegeType int = ?; " & vbcrlf &_
  "DECLARE @Status int = ?; " & vbcrlf &_
  "DECLARE @SecurityQuestion nvarchar(50) = ?; " & vbcrlf &_
  "DECLARE @SecurityAnswer nvarchar(50) = ?; " & vbcrlf &_
  "DECLARE @Password nvarchar(50) = ?; " & vbcrlf &_
  "DECLARE @CompanyContactName nvarchar(100) = ?; " & vbcrlf &_
  "DECLARE @ContactJobTitle nvarchar(50) = ?; " & vbcrlf &_
  "DECLARE @ContactName nvarchar(50) = ?; " & vbcrlf &_
  "DECLARE @MailingAddressID int = ?; " & vbcrlf &_
  "DECLARE @LoginMailingAddressID int = ?; " & vbcrlf &_
  "DECLARE @AccountManager bit = ?; " & vbcrlf &_
  "DECLARE @LoginId int = ?; " & vbcrlf &_
  "UPDATE " & vbCrLf &_
  "  myLogins " & vbCrLf &_
  "SET " & vbCrLf &_ 
  "  email = @email," & vbCrLf &_
  "  cellphone = @cellphone, " & vbCrLf &_
  "  Active = @Active, " & vbCrLf &_
  "  PrivilegeType = @PrivilegeType, " & vbCrLf &_
  "  Status = @Status, " & vbCrLf &_
  "  SecurityQuestion = @SecurityQuestion, " & vbCrLf &_
  "  SecurityAnswer = @SecurityAnswer, " & vbCrLf &_
  "  Password = (CASE WHEN @Password <> '' THEN @Password ELSE Password END), " & vbCrLf &_
  "  LoginAttempt = (CASE WHEN @Password <> '' THEN 0 ELSE LoginAttempt END), " & vbCrLf &_
  "  MustChangePassword = (CASE WHEN @Password <> '' THEN 1 ELSE MustChangePassword END), " & vbCrLf &_
  "  CompanyContactName = @CompanyContactName, " & vbCrLf &_
  "  ContactJobTitle = @ContactJobTitle, " & vbCrLf &_
  "  ContactName = @ContactName, " & vbCrLf &_
  "  MailingAddressID = @MailingAddressID, " & vbCrLf &_
  "  LoginMailingAddressID = @LoginMailingAddressID, " & vbCrLf &_
  "  AccountManager = @AccountManager" & vbCrLf &_
  "WHERE " & vbcrlf &_
  "  LoginId = @LoginId " & vbCrLf

  
  Dim cmd 
  Set cmd = Server.CreateObject("ADODB.Command")
  cmd.CommandType = adCmdText
  cmd.ActiveConnection = TagDB
  cmd.CommandText = sSql

  '-----------------------------
  Dim contact_email : contact_email = "" 
  Dim contact_cell : contact_cell = ""
  Dim Active : Active = ""
  Dim old_privilege : old_privilege = 1
  Dim PrivilegeType : PrivilegeType = 2
  Dim question : question = "" 
  Dim answer : answer = ""
  Dim password1 : password1 = "ddd"
  Dim company_name : company_name = ""
  Dim contact_title : contact_title = ""
  Dim contact_name : contact_name = ""
  Dim mailing_addr_id : mailing_addr_id = 1
  Dim login_mailing_addr_id : login_mailing_addr_id = 1
  Dim AccountManager : AccountManager = False
  Dim loginId : loginId = 7
  '-----------------------------

  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, contact_email)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 32, contact_cell)
  
  Dim isActive
  If (Active <> "") Then
    isActive = True
  Else
    isActive = False
  End If
  cmd.Parameters.Append cmd.CreateParameter( , adBoolean, adParamInput, , isActive)

  Dim m_PrivilegeType, m_Status
  m_PrivilegeType = old_privilege

  If PrivilegeType <> old_privilege Then
    m_PrivilegeType = PrivilegeType
    If IsApprovalRequired(PrivilegeType) Then
      m_Status = LOGIN_STATUS_PENDING
    Else
      m_Status = LOGIN_STATUS_APPROVED
    End If
  End If
  cmd.Parameters.Append cmd.CreateParameter( , adInteger, adParamInput, , m_PrivilegeType)
  cmd.Parameters.Append cmd.CreateParameter( , adInteger, adParamInput, , m_Status)

  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 50, question)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 50, answer)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 50, iUtils_crypto(Password1))

  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 100, company_name)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 50, contact_title)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 50, contact_name)

  If mailing_addr_id <> 0 Then
    cmd.Parameters.Append cmd.CreateParameter( , adInteger, adParamInput, , mailing_addr_id)
  Else
    cmd.Parameters.Append cmd.CreateParameter( , adInteger, adParamInput, , NULL)
  End If

  If login_mailing_addr_id <> 0 Then
    cmd.Parameters.Append cmd.CreateParameter( , adInteger, adParamInput, , login_mailing_addr_id)
  Else
    cmd.Parameters.Append cmd.CreateParameter( , adInteger, adParamInput, , NULL)
  End If

  cmd.Parameters.Append cmd.CreateParameter( , adBoolean, adParamInput, , AccountManager)
  cmd.Parameters.Append cmd.CreateParameter( , adInteger, adParamInput, , loginId)

  On Error Resume Next
  cmd.Execute

  If (TagDB.Errors.Count) Then
    Call DisplaySqlError(sSql)
    updateMylogin = False
    Exit Function
  End If

  Response.Write("Now, updaate 'myLoginModule'.")
  Dim TempLModule : TempLModule = ""
  Dim TempRModule : TempRModule = ""

  sSql = _
  "DECLARE @LModules nvarchar(255) = ?; " & vbcrlf &_
  "DECLARE @RModules nvarchar(255) = ?; " & vbcrlf &_
  "DECLARE @LoginId int = ?; " & vbcrlf &_
  "UPDATE " & vbCrLf &_
  "  myLoginModule " & vbCrLf &_
  "SET " & vbCrLf &_
  "  LModules =  @LModules, " & vbCrLf &_
  "  RModules = @RModules " & vbCrLf &_
  "WHERE " & vbCrLf &_
  "  LoginId = @LoginId " & vbCrLf

  Set cmd = Server.CreateObject("ADODB.Command")
  cmd.CommandType = adCmdText
  cmd.ActiveConnection = TagDB
  cmd.CommandText = sSql

  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, TempLModule)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, TempRModule)
  cmd.Parameters.Append cmd.CreateParameter( , adInteger, adParamInput, , loginId)

  On Error Resume Next
  cmd.Execute

  If (TagDB.Errors.Count) Then
    Call DisplaySqlError(sSql)
    updateMylogin = False
    Exit Function
  End If

  updateMylogin = True

  ' On Error Goto 0
  ' If (CheckSqlError()) Then
  '   DisplaySqlError(sSQL)
  '   updateMylogin = False
  '   Exit Function
  ' End If
  
  ' sSql = "UPDATE myLoginModule SET LModules = '" & TempLModule & "', RModules = '" & TempRModule & "' WHERE LoginId = " & loginId
  ' On Error Resume Next
  ' TagDB.Execute(sSql)
  ' On Error Goto 0
  ' if (CheckSqlError()) then
  '   DisplaySqlError(sSql)
  '   updateMylogin = false
  '   Exit Function
  ' end if

  
End Function

Function IsApprovalRequired(sometype)
  IsApprovalRequired = True
End Function

Function iUtils_crypto(password)
  iUtils_crypto = password
End Function
%>