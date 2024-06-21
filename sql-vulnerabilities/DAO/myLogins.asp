<%
Function myLogins__insert(_
    LoginId,
    LoginName,
    email,
    cellphone,
    Password,
    PrivilegeType,
    ModuleStatus,
    Active,
    CreateDate,
    LastModDate,
    SecurityQuestion,
    SecurityAnswer,
    LoginAttempt,
    MustChangePassword,
    CompanyContactName,
    CompanyContactAddressId,
    MailingAddressID,
    ContactJobTitle,
    ContactName,
    ContactAddressID,
    LoginMailingAddressID,
    Status,
    AccountManager,
    enrolledMfaChannelId,
    hashedPassword,
    loginType,
    MFA_TOTP_Seed,
    MFA_TOTP_FriendlyName,
    MFA_TOTP_Secret,
    MFA_TOTP_sid,
    MFA_TOTP_uri,
    MFA_TOTP_status
  )
  Dim sql = _
  "DECLARE @LoginId int = ?;" & vbCrLf &_
	"DECLARE @LoginName nvarchar = ?;" & vbCrLf &_
	"DECLARE @email nvarchar = ?;" & vbCrLf &_
	"DECLARE @cellphone varchar = ?;" & vbCrLf &_
	"DECLARE @Password nvarchar = ?;" & vbCrLf &_
	"DECLARE @PrivilegeType int = ?;" & vbCrLf &_
	"DECLARE @ModuleStatus int = ?;" & vbCrLf &_
	"DECLARE @Active bit = ?;" & vbCrLf &_
	"DECLARE @CreateDate datetime = ?;" & vbCrLf &_
	"DECLARE @LastModDate datetime = ?;" & vbCrLf &_
	"DECLARE @SecurityQuestion nvarchar = ?;" & vbCrLf &_
	"DECLARE @SecurityAnswer nvarchar = ?;" & vbCrLf &_
	"DECLARE @LoginAttempt int = ?;" & vbCrLf &_
	"DECLARE @MustChangePassword bit = ?;" & vbCrLf &_
	"DECLARE @CompanyContactName nvarchar = ?;" & vbCrLf &_
	"DECLARE @CompanyContactAddressId int = ?;" & vbCrLf &_
	"DECLARE @MailingAddressID int = ?;" & vbCrLf &_
	"DECLARE @ContactJobTitle nvarchar = ?;" & vbCrLf &_
	"DECLARE @ContactName nvarchar = ?;" & vbCrLf &_
	"DECLARE @ContactAddressID int = ?;" & vbCrLf &_
	"DECLARE @LoginMailingAddressID int = ?;" & vbCrLf &_
	"DECLARE @Status int = ?;" & vbCrLf &_
	"DECLARE @AccountManager bit = ?;" & vbCrLf &_
	"DECLARE @enrolledMfaChannelId int = ?;" & vbCrLf &_
	"DECLARE @hashedPassword varchar = ?;" & vbCrLf &_
	"DECLARE @loginType varchar = ?;" & vbCrLf &_
	"DECLARE @MFA_TOTP_Seed varchar = ?;" & vbCrLf &_
	"DECLARE @MFA_TOTP_FriendlyName nvarchar = ?;" & vbCrLf &_
	"DECLARE @MFA_TOTP_Secret varchar = ?;" & vbCrLf &_
	"DECLARE @MFA_TOTP_sid varchar = ?;" & vbCrLf &_
	"DECLARE @MFA_TOTP_uri varchar = ?;" & vbCrLf &_
	"DECLARE @MFA_TOTP_status varchar = ?;" & vbCrLf &_
  "INSERT INTO myLogins" & vbCrLf &_
  "(" & vbCrLf &_
  "  LoginId," & vbCrLf &_
  "  LoginName," & vbCrLf &_
  "  email," & vbCrLf &_
  "  cellphone," & vbCrLf &_
  "  Password," & vbCrLf &_
  "  PrivilegeType," & vbCrLf &_
  "  ModuleStatus," & vbCrLf &_
  "  Active," & vbCrLf &_
  "  CreateDate," & vbCrLf &_
  "  LastModDate," & vbCrLf &_
  "  SecurityQuestion," & vbCrLf &_
  "  SecurityAnswer," & vbCrLf &_
  "  LoginAttempt," & vbCrLf &_
  "  MustChangePassword," & vbCrLf &_
  "  CompanyContactName," & vbCrLf &_
  "  CompanyContactAddressId," & vbCrLf &_
  "  MailingAddressID," & vbCrLf &_
  "  ContactJobTitle," & vbCrLf &_
  "  ContactName," & vbCrLf &_
  "  ContactAddressID," & vbCrLf &_
  "  LoginMailingAddressID," & vbCrLf &_
  "  Status," & vbCrLf &_
  "  AccountManager," & vbCrLf &_
  "  enrolledMfaChannelId," & vbCrLf &_
  "  hashedPassword," & vbCrLf &_
  "  loginType," & vbCrLf &_
  "  MFA_TOTP_Seed," & vbCrLf &_
  "  MFA_TOTP_FriendlyName," & vbCrLf &_
  "  MFA_TOTP_Secret," & vbCrLf &_
  "  MFA_TOTP_sid," & vbCrLf &_
  "  MFA_TOTP_uri," & vbCrLf &_
  "  MFA_TOTP_status" & vbCrLf &_
  ")" & vbCrLf &_
  "VALUES(" & vbCrLf &_
  "  @LoginId," & vbCrLf &_
  "  @LoginName," & vbCrLf &_
  "  @email," & vbCrLf &_
  "  @cellphone," & vbCrLf &_
  "  @Password," & vbCrLf &_
  "  @PrivilegeType," & vbCrLf &_
  "  @ModuleStatus," & vbCrLf &_
  "  @Active," & vbCrLf &_
  "  @CreateDate," & vbCrLf &_
  "  @LastModDate," & vbCrLf &_
  "  @SecurityQuestion," & vbCrLf &_
  "  @SecurityAnswer," & vbCrLf &_
  "  @LoginAttempt," & vbCrLf &_
  "  @MustChangePassword," & vbCrLf &_
  "  @CompanyContactName," & vbCrLf &_
  "  @CompanyContactAddressId," & vbCrLf &_
  "  @MailingAddressID," & vbCrLf &_
  "  @ContactJobTitle," & vbCrLf &_
  "  @ContactName," & vbCrLf &_
  "  @ContactAddressID," & vbCrLf &_
  "  @LoginMailingAddressID," & vbCrLf &_
  "  @Status," & vbCrLf &_
  "  @AccountManager," & vbCrLf &_
  "  @enrolledMfaChannelId," & vbCrLf &_
  "  @hashedPassword," & vbCrLf &_
  "  @loginType," & vbCrLf &_
  "  @MFA_TOTP_Seed," & vbCrLf &_
  "  @MFA_TOTP_FriendlyName," & vbCrLf &_
  "  @MFA_TOTP_Secret," & vbCrLf &_
  "  @MFA_TOTP_sid," & vbCrLf &_
  "  @MFA_TOTP_uri," & vbCrLf &_
  "  @MFA_TOTP_status" & vbCrLf &_
  ")" & vbCrLf

  Dim cmd 
  Set cmd = Server.CreateObject("ADODB.Command")
  cmd.CommandType = adCmdText
  cmd.ActiveConnection = TagDB
  cmd.CommandText = sSql

  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, LoginId)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, LoginName)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, email)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, cellphone)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, Password)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, PrivilegeType)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, ModuleStatus)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, Active)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, CreateDate)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, LastModDate)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, SecurityQuestion)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, SecurityAnswer)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, LoginAttempt)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, MustChangePassword)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, CompanyContactName)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, CompanyContactAddressId)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, MailingAddressID)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, ContactJobTitle)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, ContactName)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, ContactAddressID)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, LoginMailingAddressID)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, Status)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, AccountManager)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, enrolledMfaChannelId)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, hashedPassword)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, loginType)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, MFA_TOTP_Seed)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, MFA_TOTP_FriendlyName)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, MFA_TOTP_Secret)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, MFA_TOTP_sid)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, MFA_TOTP_uri)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, MFA_TOTP_statu)

End Function



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

  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, email)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 32, cellphone)
  cmd.Parameters.Append cmd.CreateParameter( , adBoolean, adParamInput, , Active)
  cmd.Parameters.Append cmd.CreateParameter( , adInteger, adParamInput, , PrivilegeType)
  cmd.Parameters.Append cmd.CreateParameter( , adInteger, adParamInput, , Status)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, SecurityQuestion)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, SecurityAnswer)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, Password)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, CompanyContactName)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, ContactJobTitle)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, ContactName)
  cmd.Parameters.Append cmd.CreateParameter( , adInteger, adParamInput, , MailingAddressID)
  cmd.Parameters.Append cmd.CreateParameter( , adInteger, adParamInput, 255, LoginMailingAddressID)
  cmd.Parameters.Append cmd.CreateParameter( , adBoolean, adParamInput, , AccountManager)
  cmd.Parameters.Append cmd.CreateParameter( , adInteger, adParamInput, , LoginId)

  On Error Resume Next
  cmd.Execute
  If (TagDB.Errors.Count) Then
    Call DisplaySqlError(sSql)
    Exit Function
  End If
  myLogins__update = True
End Function
%>