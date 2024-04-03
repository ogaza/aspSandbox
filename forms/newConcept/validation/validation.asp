<%
Function RequiredFieldProvided(fieldValue) 
  RequiredFieldProvided   = False
  If "" <> fieldValue Then
    RequiredFieldProvided   = True
    ' sErrMsg = sErrMsg & "<A HREF=javascript:fnFieldFocus(document.frmApplication.cboCompanyCountry)><BR><B>"
    ' sErrMsg = sErrMsg & COMPANY_COUNTRY_LABEL & "</B></A> -- required field."
	End If
End Function

Function HasMaxLengthOf(fieldValue, maxLength)
  HasMaxLengthOf = False
  If(Len(fieldValue) < maxLength + 1) Then
    HasMaxLengthOf = True
  End If
End Function

Function EmailHasValidFormat(email)
  EmailHasValidFormat = False

  Dim rex
  Set rex = new regexp
  'rex.Pattern = "^[_a-z0-9-]+(.[a-z0-9-]+)@[a-z0-9-]+(.[a-z0-9-]+)*(.[a-z]{2,4})$"
  rex.Pattern = "^$|^[0-9a-zA-Z]+[0-9a-zA-Z\\+\-_\\.\\'&\\#/]*[0-9a-zA-Z]+@[0-9a-zA-Z\\-]+[\\.]{1}[0-9a-zA-Z\\-\\.]*[0-9a-zA-Z]+$"
  If (rex.Execute(email).Count = 1) Then
    errMsg = "incorrect format"
    EmailHasValidFormat = True
  End If
  Set rex = Nothing

End Function
%>