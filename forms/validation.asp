<%
Function ValidateForm()
  ValidateForm = ""

  Dim sErrMsgHeader, sErrMsg
  sErrMsgHeader = "Please correct or provide more information in the fields below:"
  sErrMsg = ""

  Dim sValidEmailErrorMessage, bValidEmail
  bValidEmail = iUtils_valiEmail(m_sCompanyEmail, sValidEmailErrorMessage)
  If Not bValidEmail Then
    If (sValidEmailErrorMessage <> "") Then
      sErrMsg = sErrMsg & _
        "<A HREF=javascript:fnFieldFocus(document.frmApplication.txtCompanyEmail)>" & _
        "<BR><B>" & COMPANY_EMAIL_LABEL & "</B>" & _ 
        "</A>" & _ 
        " -- incorrect format."
    End If
  End If

  If sErrMsg <> "" Then
    ValidateForm = "" & _
    "<TABLE cellpadding='1' border='0'>" & _
    "<TR align='top'>" & _
    "<TD align='left'>" & _
    "<FONT SIZE=2 COLOR='#ff0000'>" &  _
      sErrMsgHeader & _
    "</FONT>" & _
    "<FONT  SIZE=2>" & _
      sErrMsg & _
    "</FONT>" & _ 
    "</TD>" & _
    "</TR>" & _ 
    "</TABLE>"
  End If
End Function

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

  Dim bValidEmail
  ' bValidEmail = iUtils_valiEmail(email)

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

'======================================================================================
'  function:  iUtils_valiEmail
'  validate an email address's format
'  Task 59271: DEV VERRA- Email Address Validation for Invalid Characters
'======================================================================================
function iUtils_valiEmail(email, errMsg)
  iUtils_valiEmail = True
  errMsg = ""

  Dim AllEmptyEmail
  Dim checkEmail

  AllEmptyEmail = true
  email = rtrim(ltrim(email))

  if( email = "") then
    iUtils_valiEmail = False
    exit function
  else
    Dim eArr, e1
    eArr = Split(email, ";")
    for each e1 in eArr
      If e1 <> "" Then
        AllEmptyEmail = False
        checkEmail = iUtils_valid_1_Email(e1, errMsg)
        If (checkEmail = False) Then
          errMsg = "incorrect format"
          iUtils_valiEmail = False
          exit function
        End If
      End If
    Next
  end if

  if AllEmptyEmail then
    errMsg = "Empty Email"
    iUtils_valiEmail = False
    exit function
  end if
end function

function iUtils_valid_1_Email(email, errMsg)
  iUtils_valid_1_Email = True
  errMsg = ""
  email = trim(email)
  if( email = "") then
    iUtils_valid_1_Email = False
  else
    Dim rex
    Set rex = new regexp
    'rex.Pattern = "^[_a-z0-9-]+(.[a-z0-9-]+)@[a-z0-9-]+(.[a-z0-9-]+)*(.[a-z]{2,4})$"
    rex.Pattern = "^$|^[0-9a-zA-Z]+[0-9a-zA-Z\\+\-_\\.\\'&\\#/]*[0-9a-zA-Z]+@[0-9a-zA-Z\\-]+[\\.]{1}[0-9a-zA-Z\\-\\.]*[0-9a-zA-Z]+$"
    If (rex.Execute(email).Count <> 1) Then
      errMsg = "incorrect format"
      iUtils_valid_1_Email = False
    End If

    Set rex = Nothing
  end if
end function
%>