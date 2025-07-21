<%
Function myLogins__insert(_
    LoginId,_
    LoginName,_
    email,_
    cellphone,_
    Password,_
    PrivilegeType,_
    ModuleStatus,_
    Active,_
    CreateDate,_
    LastModDate,_
    SecurityQuestion,_
    SecurityAnswer,_
    LoginAttempt,_
    MustChangePassword,_
    CompanyContactName,_
    CompanyContactAddressId,_
    MailingAddressID,_
    ContactJobTitle,_
    ContactName,_
    ContactAddressID,_
    LoginMailingAddressID,_
    Status,_
    AccountManager,_
    enrolledMfaChannelId,_
    hashedPassword,_
    loginType,_
    MFA_TOTP_Seed,_
    MFA_TOTP_FriendlyName,_
    MFA_TOTP_Secret,_
    MFA_TOTP_sid,_
    MFA_TOTP_uri,_
    MFA_TOTP_status _
  )
  Dim sql
  sql = _
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

Function mylogins__selectHavingRecLogins(loginId, ahId, privilegeType, errorMsg)
  Dim sql
  sql = _
  "DECLARE @loginId INT = ?; " & vbCrLf &_
  "DECLARE @ahId INT = ?; " & vbCrLf &_
  "DECLARE @privilegeType INT = ?; " & vbCrLf &_
  "SELECT " & vbCrLf &_
  "  l.* " & vbCrLf &_
  "  -- l.*, " & vbCrLf &_
  "  -- OtherFlag, " & vbCrLf &_
  "  -- BBTransfer  " & vbCrLf &_
  "FROM " & vbCrLf &_
  "  mylogins l, " & vbCrLf &_
  "  reclogin rl " & vbCrLf &_
  "WHERE " & vbCrLf &_
  "  rl.loginID = l.loginID " & vbCrLf &_
  "  AND rl.ahID = @ahId " & vbCrLf &_
  "  AND l.LoginID = @loginId " & vbCrLf &_
  "  AND (@privilegeType <> 32 OR l.PrivilegeType NOT IN (16)) " & vbCrLf

  Dim cmd
  Set cmd = Server.CreateObject("ADODB.Command")
  cmd.CommandType = adCmdText
  cmd.ActiveConnection = TagDB
  cmd.CommandText = sql

  cmd.Parameters.Append cmd.CreateParameter( , adInteger, adParamInput, , loginId)
  cmd.Parameters.Append cmd.CreateParameter( , adInteger, adParamInput, , ahId)
  cmd.Parameters.Append cmd.CreateParameter( , adInteger, adParamInput, , privilegeType)

  Dim oRs
  Set oRs = Server.CreateObject("ADODB.Recordset")
  oRs.CursorLocation = adUseClient
  On Error Resume Next
  oRs.Open cmd ', ,adOpenStatic, adLockReadOnly
  ' Set oRs = cmd.Execute
  On Error Goto 0

  ' DEBUG:
  ' Response.Write("oRs.RecordCount: " & oRs.RecordCount & "</br>")

  If (TagDB.Errors.Count) Then
    errorMsg = "Database error when retrieving mylogins."
    ' oRs.Close
    Set oRs = Nothing
    Call DisplaySqlError(sql)
    Exit Function
  End If

  Dim numberOfColumns
  numberOfColumns = oRs.Fields.Count
  ' Response.Write("numberOfColumns: " & numberOfColumns & "</br>")
  ' Response.Write("oRs.RecordCount: " & oRs.RecordCount & "</br>")

  ReDim arr(oRs.RecordCount - 1)
  ReDim row(numberOfColumns - 1)
  Dim rowIdx : rowIdx = 0
  Dim colIdx : colIdx = 0
  While Not oRs.EOF
    ' DEBUG:
    ' Response.Write("oRs.Fields.Item(0): " & oRs.Fields.Item(0) & "</br>")
    For colIdx = 0 to (numberOfColumns - 1)
      row(colIdx) = oRs.Fields.Item(colIdx)
    Next
    ' row(0) = oRs.Fields.Item(0)
    ' row(1) = oRs.Fields.Item(1)
    ' row(2) = oRs.Fields.Item(2)

    arr(rowIdx) = row

    oRs.MoveNext
    rowIdx = rowIdx + 1
  Wend

  oRs.Close
  Set oRs = Nothing

  mylogins__selectHavingRecLogins = arr
End Function

Function myLogins__update(loginId, loginName, errMsg)

  myLogins__update = False

  Dim oRs, sSql, oCom

  sSql = "SELECT * FROM myLogins WHERE LoginId = ?"

  Set oCom = Server.CreateObject("ADODB.Command")
  oCom.CommandType = adCmdText
  oCom.ActiveConnection = TagDB
  oCom.CommandText = sSql

  oCom.Parameters.Append oCom.CreateParameter( , adInteger, adParamInput, , loginId)

  Set oRs = Server.CreateObject("ADODB.Recordset")
  On Error Resume Next
  oRs.Open oCom, , adOpenKeyset, adOpenDynamic
  ' Call oRs.Open("SELECT * FROM myLogins WHERE LoginId = " & m_iLoginId, TagDB, adOpenKeyset, adOpenDynamic)

  oRs.Fields("LoginName") = loginName

  oRs.Update()
  On Error goto 0

  If (TagDB.Errors.Count) Then
    errMsg = TagDB.Errors.Item(0).Description
    Exit Function
  End If

  oRs.Close()
  Set oRs =  Nothing

  myLogins__update = True
End Function

Function myLogins__select_using_rs(loginId, errMsg)

  Dim TagDB
  Set TagDB = Server.CreateObject("ADODB.Connection")
  TagDB.Open(VerraDevDatabase)

  Dim oRs, criteria

  Set oRs = Server.CreateObject("ADODB.Recordset")

  On Error Resume Next
  ' oRs.Open "myLogins", TagDB, adOpenKeyset, adLockOptimistic, adCmdTable
  Call oRs.Open("myLogins", TagDB, adOpenKeyset, adLockOptimistic, adCmdTable)

  criteria = "LoginId = " & CInt(loginId)

  oRs.Find criteria

  Response.Write("LoginName: " & oRs.Fields.Item("LoginName") & "</br>")

  On Error goto 0
  ' If (TagDB.Errors.Count) Then
  '   errMsg = TagDB.Errors.Item(0).Description
  '   Exit Function
  ' End If

  oRs.Close()
  ' Set oRs =  Nothing

  TagDB.Close()

End Function
%>