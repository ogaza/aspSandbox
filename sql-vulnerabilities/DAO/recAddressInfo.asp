<%
Function recAddressInfo__update(address_id, addr1, addr2, city, state, zip, country, tel, fax, email, url)
  recAddressInfo__update = False

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
    Exit Function
  End If
  recAddressInfo__update = True
End Function

Function recAddressInfo__delete(addressID)
  recAddressInfo__delete = false
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
  recAddressInfo__delete = True
End Function
%>