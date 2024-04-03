<%

' not used in this solution, just copied from verra to see how it works there
Function ValidateZip_VerraStyle

  Dim zipMaxLength
  zipMaxLength = 8

  Dim sErrMsg
  sErrMsg = ""

  If (m_sCompanyZip = "") Then
    sErrMsg = sErrMsg & _
      "<A HREF=javascript:fnFieldFocus(document.forms[0].companyZip)><B>" & _
      COMPANY_ZIP_LABEL & _ 
      "</B></A> -- required field."
  ElseIf (Len(m_sCompanyZip) > zipMaxLength) Then
    sErrMsg = sErrMsg & _ 
      "<A HREF=javascript:fnFieldFocus(document.forms[0].companyZip)><B>" & _
      COMPANY_ZIP_LABEL & _
      "</B></A> -- max length is " & zipMaxLength & " characters."
  ElseIf Not iUtils_validZip("US", m_sCompanyZip) Then
    sErrMsg = sErrMsg & _
      "<A HREF=javascript:fnFieldFocus(document.forms[0].companyZip)><B>" & _
      COMPANY_ZIP_LABEL & _ 
      "</B></A> -- incorrect format."
  End If

  ValidateZip_VerraStyle = sErrMsg
End Function

Function ValidateForm()
  ValidateForm = ""

  Dim sErrMsgHeader, sErrMsg
  sErrMsgHeader = "Please correct or provide more information in the fields below:"
  sErrMsg = ""

  Dim sValidEmailErrorMessage, bValidEmail
  bValidEmail = iUtils_validEmail(m_sCompanyEmail, sValidEmailErrorMessage)
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

'======================================================================================
'  function:  iUtils_validEmail
'  validate an email address's format
'  Task 59271: DEV VERRA- Email Address Validation for Invalid Characters
'======================================================================================
function iUtils_validEmail(email, errMsg)
  iUtils_validEmail = True
  errMsg = ""

  Dim AllEmptyEmail
  Dim checkEmail

  AllEmptyEmail = true
  email = rtrim(ltrim(email))

  if( email = "") then
    iUtils_validEmail = False
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
          iUtils_validEmail = False
          exit function
        End If
      End If
    Next
  end if

  if AllEmptyEmail then
    errMsg = "Empty Email"
    iUtils_validEmail = False
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

Function iUtils_ValidZip(sCountry, sZip)
  iUtils_ValidZip = False
  sZip = Trim(sZip)

  Dim i, selChar
  Select Case sCountry
    Case "US", "MX":      '1 for US and 2 for Mexico
      If (Len(sZip) = 5) Then
        For i = 1 To Len(sZip)
          selChar = mid(sZip, i, 1)
          If (Not IsNumeric(selChar)) Then Exit Function
        Next
        iUtils_validZIP = True
      End If
    Case "CA":        '3 for Canada
      If (Len(sZip) = 6) Then
        For i = 1 To Len(sZip)
          selChar = mid(sZip, i, 1)
          If i = 2 or i = 4 or i = 6 Then
            If (Not IsNumeric(selChar)) Then Exit Function
          Else
            If (Not((selChar >= chr(65) and selChar <= chr(90)) OR (selChar>= chr(97) and selChar <= chr(122)))) Then Exit Function
          End If
        Next
        iUtils_validZIP = True
      End If
    Case Else:
      iUtils_ValidZip = True ' For a country besides US and Canada, there should be no zip validation.
  End Select
End Function
%>