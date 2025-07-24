<%
'======================================================================================
' Pass in a string obtained from a QueryString, Form or ... parameter to validate that
'  it doesn't contain single quotes.
' This will prevent harmful SQL statments being embedded in this parameter.
' If you set bHandle to False you should check the return value to do your
'  own handling.
'======================================================================================
Function CheckForSafeStringParameter(ByVal bHandle, ByRef sParameter)
	sParameter = CStr(sParameter)

	Dim bReturn
    ' One more check in file myPageHeader.asp
    bReturn = (Not IsEmpty(sParameter) _
        And Not InStr(sParameter, "<") > 0 _
        And Not InStr(sParameter, ">") > 0 _
        And Not InStr(sParameter, "&lt;") > 0 _
        And Not InStr(sParameter, "&gt;") > 0 _
        And Not InStr(sParameter, "--") > 0 _
        And Not InStr(sParameter, """") > 0 _
        And Not InStr(sParameter, "%3C") > 0 _
        And Not InStr(sParameter, "%3E") > 0 _
        )

    Response.Write "breturn: " & bReturn & "</br>"

	If (Not bReturn) Then
		If (bHandle) Then
			Call HandleUnsafeStringParameter(sParameter)
		Else
			sParameter = Replace(sParameter, "'", "''")
		End If
	End If

	CheckForSafeStringParameter = bReturn
End Function

Function CheckForSafeStringParameterIfNotEmpty(ByVal bHandle, ByRef sParameter)
  Dim bReturn
  if Not IsEmpty(sParameter) And sParameter <> ""  Then
   bReturn = CheckForSafeStringParameter(bHandle, sParameter)
  Else
   bReturn = True
  End If

  CheckForSafeStringParameterIfNotEmpty = bReturn
End Function

'======================================================================================
' Handling for an unsafe string obtained from a QueryString, Form or ... parameter.
'======================================================================================
Sub HandleUnsafeStringParameter(ByVal sParameter)
	Response.Write("unsafe param </br>")

	Call CommonSecurityProblemHandler()
End Sub

Sub HandleUnsafeStringParameter_v2(ByVal sParameter)

  Response.Write("unsafe param </br>")
  ' Response.End

  Call CommonSecurityProblemHandler()

End Sub

Sub CommonSecurityProblemHandler()
	' Response.Write("<BR>Invalid URL, " & "the " & APPLICATION_NAME & " Administrator has been notified!")
	Response.End()
End Sub
%>