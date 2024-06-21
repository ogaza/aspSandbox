<title>actMgtDetail sandbox</title>
<!-- links to js and css shoul be at the top in order for them to be placed in the head by the browser-->
<!--<script src="index.js" defer type="module"></script> -->
<!-- end of links -->

<!-- includes for asp with code here -->

<!--#include virtual="/Auth/Services/ApxSecurity.inc.asp"-->
<!--#include virtual="/Auth/Services/Authservice.asp"-->
<!--#include virtual="/DB/iDBPointer.asp"-->
<!--#include virtual="/DB/iDB.asp"-->

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

Dim result 
result = myLoginPrivileges__insert(2, True, True, True)
Response.Write("myLoginPrivileges__insert result: " & result & "</br>")

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
Function myLoginPrivileges__insert(loginid, canCreateNewFacility, otherFlag, bbTransfer)
	myLoginPrivileges__insert = False

  Dim sql 
  sql = _
  "DECLARE @loginid int = ?; " & vbCrLf &_
  "DECLARE @CanCreateNewFacility bit = ?; " & vbCrLf &_
  "DECLARE @OtherFlag bit = ?; " & vbCrLf &_
  "DECLARE @BBTransfer bit = ?; " & vbCrLf &_
  "INSERT INTO  " & vbCrLf &_
  "  myLoginPrivileges " & vbCrLf &_
  "  ( " & vbCrLf &_
  "    loginid, " & vbCrLf &_
  "    CanCreateNewFacility, " & vbCrLf &_
  "    OtherFlag, " & vbCrLf &_
  "    BBTransfer " & vbCrLf &_
  "  ) " & vbCrLf &_
  "VALUES " & vbCrLf &_
  "( " & vbCrLf &_
  "  @loginid,  " & vbCrLf &_
  "  @CanCreateNewFacility, " & vbCrLf &_
  "  @OtherFlag, " & vbCrLf &_
  "  @BBTransfer " & vbCrLf &_
  "); " & vbCrLf
  
  Dim cmd 
  Set cmd = Server.CreateObject("ADODB.Command")
  cmd.CommandType = adCmdText
  cmd.ActiveConnection = TagDB
  cmd.CommandText = sql

  cmd.Parameters.Append cmd.CreateParameter( , adInteger, adParamInput, , loginid)
  cmd.Parameters.Append cmd.CreateParameter( , adBoolean, adParamInput, , canCreateNewFacility)
  cmd.Parameters.Append cmd.CreateParameter( , adBoolean, adParamInput, , otherFlag)
  cmd.Parameters.Append cmd.CreateParameter( , adBoolean, adParamInput, , bbTransfer)

  On Error Resume Next
  cmd.Execute
  On Error Goto 0
  If (TagDB.Errors.Count) Then
    Call DisplaySqlError(sSql)
    Exit Function
  End If
  myLoginPrivileges__insert = True
End Function

Function RecLogin__insert(loginId, ahId)
	RecLogin__insert = False
	If (loginId <= 0 or ahId <= 0) Then 
    Exit Function
  End If
	
	Dim sql
  sql = _
  "DECLARE @loginId INT = ?; " & vbCrLf &_
  "DECLARE @ahId INT = ?; " & vbCrLf &_
  "INSERT INTO " & vbCrLf &_
  "  recLogin(loginId, ahId) " & vbCrLf &_
  "VALUES " & vbCrLf &_
  "  (@loginId, @ahId) " & vbCrLf

  Dim cmd
	Set cmd = Server.CreateObject("ADODB.Command")
  cmd.CommandType = adCmdText
  cmd.ActiveConnection = TagDB
  cmd.CommandText = sql
	
  cmd.Parameters.Append cmd.CreateParameter( , adInteger, adParamInput, , loginId)
  cmd.Parameters.Append cmd.CreateParameter( , adInteger, adParamInput, , ahId)

  On Error Resume Next
  cmd.Execute
  On Error GoTo 0

  If (TagDB.Errors.Count > 0) Then
    Call DisplaySqlError(sql)
    Exit Function
	End If
  RecLogin__insert = True
End Function

Function RecAddressInfo__delete(addressID)
	Dim sql 
	sql = _
	"DECLARE @addressID INT = ?; " & vbCrLf &_
	"DELETE " & vbCrLf &_
	"FROM " & vbCrLf &_
	"  recAddressInfo " & vbCrLf &_
	"WHERE " & vbCrLf &_
	"  addressID = @addressID" & vbCrLf

	Dim cmd
	Set cmd = Server.CreateObject("ADODB.Command")
  cmd.CommandType = adCmdText
  cmd.ActiveConnection = TagDB
  cmd.CommandText = sql

	cmd.Parameters.Append cmd.CreateParameter( , adInteger, adParamInput, , addressID)

	On Error Resume Next
  cmd.Execute

  If (TagDB.Errors.Count) Then
    Call DisplaySqlError(sql)
    Exit Function
  End If
End Function

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

Function UpdateAddressInfo(address_id, addr1, addr2, city, state, zip, country, tel, fax, email, url)
  UpdateAddressInfo = True

  Dim sSql
  sSql = _
  "DECLARE @addr1 VARCHAR(150) = ?; " & vbCrLf &_
  "DECLARE @addr2 VARCHAR(150) = ?; " & vbCrLf &_
  "DECLARE @city VARCHAR(50) = ?; " & vbCrLf &_
  "DECLARE @state VARCHAR(200) = ?; " & vbCrLf &_
  "DECLARE @zip VARCHAR(50) = ?; " & vbCrLf &_
  "DECLARE @country VARCHAR(50)  = ?; " & vbCrLf &_
  "DECLARE @tel VARCHAR(50) = ?; " & vbCrLf &_
  "DECLARE @fax VARCHAR(50) = ? " & vbCrLf &_
  "DECLARE @email VARCHAR(256) = ?; " & vbCrLf &_
  "DECLARE @url VARCHAR(256) = ?; " & vbCrLf &_
  "DECLARE @address_id INT = ?; " & vbCrLf &_
  "UPDATE " & vbCrLf &_
  "  recAddressInfo " & vbCrLf &_
  "SET " & vbCrLf &_
  "  aiStreetAddress1 = @addr1, " & vbCrLf &_
  "  aiStreetAddress2 = @addr2, " & vbCrLf &_
  "  aiCity = @city, " & vbCrLf &_
  "  aiState = @state, " & vbCrLf &_
  "  aiZipCode = @zip, " & vbCrLf &_
  "  aiCountry = @country, " & vbCrLf &_
  "  aiPhone = @tel, " & vbCrLf &_
  "  aiFax = @fax, " & vbCrLf &_
  "  aiEmail = @email, " & vbCrLf &_
  "  aiWebSite = @url " & vbCrLf &_
  "WHERE " & vbCrLf &_
  "  AddressId = @address_id " & vbCrLf

  Dim cmd 
  Set cmd = Server.CreateObject("ADODB.Command")
  cmd.CommandType = adCmdText
  cmd.ActiveConnection = TagDB
  cmd.CommandText = sSql

  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 150, addr1)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 150, addr2)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 50, city)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 200, state)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 50, zip)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 50, country)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 50, tel)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 50, fax)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 256, email)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 256, url)
  cmd.Parameters.Append cmd.CreateParameter( , adInteger, adParamInput, , address_id)

  On Error Resume Next
  cmd.Execute
  ' On Error Goto 0
  If (TagDB.Errors.Count) Then
    Call DisplaySqlError(sSql)
    UpdateAddressInfo = False
    Exit Function
  End If
  UpdateAddressInfo = True
End Function
%>