<%
Function myLogins__update(_
    email, _
    cellphone, _
    Active, _
    PrivilegeType, _
    Status, _
    SecurityQuestion, _
    SecurityAnswer, _
    Password, _
    CompanyContactName, _
    ContactJobTitle, _
    ContactName, _
    MailingAddressID, _
    LoginMailingAddressID, _
    AccountManager, _
    LoginId _
  )

  myLogins__update = False

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

  cmd.Parameters.Append cmd,CreateParameter( , adVarChar, adParamInput, 255, email)
  cmd.Parameters.Append cmd,CreateParameter( , adVarChar, adParamInput, 32, cellphone)
  cmd.Parameters.Append cmd,CreateParameter( , adBoolean, adParamInput, , Active)
  cmd.Parameters.Append cmd,CreateParameter( , adInteger, adParamInput, , PrivilegeType)
  cmd.Parameters.Append cmd,CreateParameter( , adInteger, adParamInput, , Status)
  cmd.Parameters.Append cmd,CreateParameter( , adVarChar, adParamInput, 255, SecurityQuestion)
  cmd.Parameters.Append cmd,CreateParameter( , adVarChar, adParamInput, 255, SecurityAnswer)
  cmd.Parameters.Append cmd,CreateParameter( , adVarChar, adParamInput, 255, Password)
  cmd.Parameters.Append cmd,CreateParameter( , adVarChar, adParamInput, 255, CompanyContactName)
  cmd.Parameters.Append cmd,CreateParameter( , adVarChar, adParamInput, 255, ContactJobTitle)
  cmd.Parameters.Append cmd,CreateParameter( , adVarChar, adParamInput, 255, ContactName)
  cmd.Parameters.Append cmd,CreateParameter( , adInteger, adParamInput, , MailingAddressID)
  cmd.Parameters.Append cmd,CreateParameter( , adInteger, adParamInput, 255, LoginMailingAddressID)
  cmd.Parameters.Append cmd,CreateParameter( , adBoolean, adParamInput, , AccountManager)
  cmd.Parameters.Append cmd,CreateParameter( , adInteger, adParamInput, , LoginId)

  On Error Resume Next
  cmd.Execute
  If (TagDB.Errors.Count) Then
    Call DisplaySqlError(sSql)
    Exit Function
  End If
  myLogins__update = True
End Function
%>