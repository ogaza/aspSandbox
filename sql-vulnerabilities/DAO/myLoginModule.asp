<%
Function myLoginModule__select( _
  loginId, loginName, orderBy, errorMsg)

  Dim sql
  sql = _
  "DECLARE @loginId INT = ?; " & vbCrLf &_
  "DECLARE @loginName NVARCHAR(50) = ?; " & vbCrLf &_
  "DECLARE @orderBy VARCHAR(100) = ?; " & vbCrLf &_
  "SELECT " & vbCrLf &_
  "  l.LoginId, " & vbCrLf &_
  "  l.LoginName, " & vbCrLf &_
  "  lm.LModules, " & vbCrLf &_
  "  lm.RModules, " & vbCrLf &_
  "  lm.LModulesSpecial, " & vbCrLf &_
  "  lm.RModulesSpecial, " & vbCrLf &_
  "  lm.MarketType " & vbCrLf &_
  "FROM " & vbCrLf &_
  "  myloginModule lm, myLogins L " & vbCrLf &_
  "WHERE " & vbCrLf &_
  "  l.loginid = lm.loginid " & vbCrLf &_
  "  AND " & vbCrLf &_
  "  ( " & vbCrLf &_
  "    (@loginId IS NULL OR @loginId <= 0) OR l.loginid = @loginId " & vbCrLf &_
  "  ) " & vbCrLf &_
  "  AND " & vbCrLf &_
  "  ( " & vbCrLf &_
  "    (@loginName IS NULL OR @loginName = '') " & vbCrLf &_
  "    OR " & vbCrLf &_
  "    ( " & vbCrLf &_
  "      l.LoginName like '%' + TRIM(@loginName) + '%' " & vbCrLf &_
  "    ) " & vbCrLf &_
  "  ) " & vbCrLf &_
  "ORDER BY " & vbCrLf &_
  "  CASE @orderBy " & vbCrLf &_
  "    WHEN 'LoginId' THEN l.LoginId " & vbCrLf &_
  "  END,   " & vbCrLf &_
  "  CASE @orderBy " & vbCrLf &_
  "    WHEN 'LoginName' THEN l.LoginName " & vbCrLf &_
  "    WHEN 'LModulesSpecial' THEN lm.LModulesSpecial " & vbCrLf &_
  "    WHEN 'RModulesSpecial' THEN lm.RModulesSpecial " & vbCrLf &_
  "  END " & vbCrLf

  ' DEBUG:
  ' Response.Write("sql: </br>" & sql & "</br>")

  Dim cmd 
  Set cmd = Server.CreateObject("ADODB.Command")
  cmd.CommandType = adCmdText
  cmd.ActiveConnection = TagDB
  cmd.CommandText = sql

  cmd.Parameters.Append cmd.CreateParameter( , adInteger, adParamInput, , loginId)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 50, loginName)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 100, orderBy)

  Dim oRs
  Set oRs = Server.CreateObject("ADODB.Recordset")
  oRs.CursorLocation = adUseClient
  On Error Resume Next
  oRs.Open cmd ', ,adOpenStatic, adLockReadOnly
  ' Set oRs = cmd.Execute
  On Error Goto 0

  ReDim arr(-1)
  ' ReDim row(-1)
  myLoginModule__select = arr

  If (TagDB.Errors.Count) Then
    ' oRs.Close
    Set oRs = Nothing
    Call DisplaySqlError(sql)
    errorMsg = "Database error when retrieving myLoginModules."
    Exit Function
  End If

  If oRs.EOF Then
    oRs.Close
    Exit Function
  End If

  Dim rowIdx : rowIdx = 0
  ReDim arr(oRs.RecordCount - 1)
  Dim item
  While Not oRs.EOF
    Set item = New MyLoginModuleData
    
    item.LoginId = oRs.Fields.Item("LoginId")
    item.LoginName = oRs.Fields.Item("LoginName")
    item.LModules = oRs.Fields.Item("LModules")
    item.RModules = oRs.Fields.Item("RModules")
    item.LModulesSpecial = oRs.Fields.Item("LModulesSpecial")
    item.RModulesSpecial = oRs.Fields.Item("RModulesSpecial")
    item.MarketType = oRs.Fields.Item("MarketType")
    
    Set arr(rowIdx) = item
    rowIdx = rowIdx + 1
    oRs.MoveNext
  Wend

  oRs.Close
  Set oRs = Nothing

  myLoginModule__select = arr
End Function

Function myLoginModule__update( _
  loginId, lModules, rModules, marketType, errorMsg)

  myLoginModule__update = False

  Dim sql
  sql = _
  "DECLARE @LoginId INT = ?; " & vbCrLf &_
  "DECLARE @LModules nvarchar(255) = ?; " & vbCrLf &_
  "DECLARE @RModules nvarchar(255) = ?; " & vbCrLf &_
  "DECLARE @MarketType nvarchar(500) = ?; " & vbCrLf &_
  "UPDATE " & vbCrLf &_
  "  myLoginModule " & vbCrLf &_
  "SET  " & vbCrLf &_
  "  LModules = COALESCE(@LModules, LModules), " & vbCrLf &_
  "  RModules = COALESCE(@RModules, RModules), " & vbCrLf &_
  "  MarketType = COALESCE(@MarketType, MarketType) " & vbCrLf &_
  "WHERE  " & vbCrLf &_
  "  LoginId = @LoginId; " & vbCrLf

  ' DEBUG:
  ' Response.Write("sql: </br>" & sql & "</br>")

  Dim cmd 
  Set cmd = Server.CreateObject("ADODB.Command")
  cmd.CommandType = adCmdText
  cmd.ActiveConnection = TagDB
  cmd.CommandText = sql

  cmd.Parameters.Append cmd.CreateParameter( , adInteger, adParamInput, , loginId)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, lModules)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, rModules)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 500, marketType)

  On Error Resume Next
  cmd.Execute
  On Error Goto 0

  If (TagDB.Errors.Count) Then
    Call DisplaySqlError(sql)
    errorMsg = "Database error when updating myLoginModules."
    Exit Function
  End If

  myLoginModule__update = True
End Function

class MyLoginModuleData
  Private m_LoginId
  Private m_LoginName
  Private m_LModules
  Private m_RModules
  Private m_LModulesSpecial
  Private m_RModulesSpecial
  Private m_MarketType

  Public Property Get LoginId()
    LoginId = m_LoginId
  End Property
  Public Property Let LoginId(param)
    m_LoginId = param
  End Property

  Public Property Get LoginName()
    LoginName = m_LoginName
  End Property
  Public Property Let LoginName(param)
    m_LoginName = param
  End Property

  Public Property Get LModules()
    LModules = m_LModules
  End Property
  Public Property Let LModules(param)
    m_LModules = param
  End Property

  Public Property Get RModules()
    RModules = m_RModules
  End Property
  Public Property Let RModules(param)
    m_RModules = param
  End Property

  Public Property Get LModulesSpecial()
    LModulesSpecial = m_LModulesSpecial
  End Property
  Public Property Let LModulesSpecial(param)
    m_LModulesSpecial = param
  End Property
  
  Public Property Get RModulesSpecial()
    RModulesSpecial = m_RModulesSpecial
  End Property
  Public Property Let RModulesSpecial(param)
    m_RModulesSpecial = param
  End Property

  Public Property Get MarketType()
    MarketType = m_MarketType
  End Property
  Public Property Let MarketType(param)
    m_MarketType = param
  End Property
End Class
%>