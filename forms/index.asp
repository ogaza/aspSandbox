<title>Form validation</title>
<!-- links to js and css shoul be at the top in order for them to be placed in the head by the browser-->
<script src="index.js" defer type="module"></script>
<link rel="stylesheet" href="form.css" />
<!-- end of links -->

<!-- includes for asp with code here -->

<!--#include virtual="/Auth/Services/ApxSecurity.inc.asp"-->
<!--#include virtual="/Auth/Services/Authservice.asp"-->
<!--#include virtual="/forms/form.asp"-->
<!--#include virtual="/forms/formValidationView.asp"-->
<!--#include virtual="/forms/validation.asp"-->

<!-- end of asp includes -->

<!-- asp code here -->
<%
RedirectIfNotLoggedIn

CheckCSRF
%>
<!-- end of asp code-->

<!--#include virtual="/Views/Common/myPageHeader.asp"-->

<%
Const COMPANY_NAME_LABEL = "Company Name"
Const COMPANY_EMAIL_LABEL = "Company Email"
Const COMPANY_ZIP_LABEL = "Company ZIP Code"
Const COMPANY_IS_NICE_LABEL = "Company Is Nice"

Dim m_sCompanyName
Dim m_sCompanyNiceness
Dim m_sCompanyIsNice
Dim m_sCompanyEmail
Dim emailMaxLength : emailMaxLength = 12
Dim m_sCompanyZip


m_sCompanyName = Request.Form("companyName")
m_sCompanyNiceness = Request.Form("companyNiceness")
m_sCompanyIsNice = m_sCompanyNiceness = "on"
m_sCompanyEmail = trim(Request.Form("companyEmail"))
m_sCompanyZip = trim(Request.Form("companyZip"))
%>

<!-- content wrapper -->
<div class="wrapper">
  <main class="main">
    <section class="section--main">
      <!-- main page content here -->
      <h2>
        Forms validation sandbox
      </h2>
      <%
        RenderForm
      %>
    </section>
  </main>
</div>

<%
If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
  ' post summary
  PrintPOSTSummary

  WriteInDiv "VALIDATION RESULT:"
  ' validate
  Dim validationErrorMessages
  validationErrorMessages = ValidateEmail
  ' render validation summary
  RenderFieldValidationResult COMPANY_EMAIL_LABEL, validationErrorMessages

  ' validate
  validationErrorMessages = ValidateZip
  ' render validation summary
  RenderFieldValidationResult COMPANY_ZIP_LABEL, validationErrorMessages
End If

Function ValidateEmail() 
  ReDim emailValidationResults(2)

  If Not RequiredFieldProvided(m_sCompanyEmail) Then
    emailValidationResults(1) = "Value is required"
  End IF

  If Not EmailHasValidFormat(m_sCompanyEmail) Then
    emailValidationResults(0) = "Wrong format"
  End IF

  If Not HasMaxLengthOf(m_sCompanyEmail, emailMaxLength) Then
    emailValidationResults(1) = "Cannot have more than " & emailMaxLength & " charcters" 
  End IF

  ValidateEmail = emailValidationResults

  ' Dim i
  ' For i = 0 To UBound(emailValidationResults)
  '   If emailValidationResults(i) <> "" Then
  '     WriteInDiv emailValidationResults(i)
  '   End If
  ' Next
  
  ' Dim d
  ' Set d = Server.CreateObject("Scripting.Dictionary")
  ' d.Add "email", validators

  ' If d.Exists("gr") = True Then
  '   Dim tmp : tmp = d.Item("gr")
  '   d.Remove("gr")
  '   d.Add "gr", "White" & " " & "Green"
  ' Else
  '   d.Add "gr","Green"
  ' End If
  ' Response.Write("The value of key gr is: " & d.Item("gr"))
  
  ' set d = Nothing

End Function

Function ValidateZip()

  Dim zipMaxLength
  zipMaxLength = 8

  ReDim validationResults(2)

  If Not RequiredFieldProvided(m_sCompanyZip) Then
    validationResults(1) = "Value is required"
  End IF

  If Not HasMaxLengthOf(m_sCompanyZip, zipMaxLength) Then
    validationResults(1) = "Cannot have more than " & zipMaxLength & " charcters"
  End IF

  If Not iUtils_validZip("US", m_sCompanyZip) Then
    validationResults(0) = "Wrong format"
  End IF

  ValidateZip = validationResults
End Function

Function ValidateZip_VerraStyle

  Dim zipMaxLength
  zipMaxLength = 8

  Dim sErrMsg
  sErrMsg = ""

  If (m_sCompanyZip = "") Then
    sErrMsg = sErrMsg & _
      "<A HREF=javascript:fnFieldFocus(document.frmApplication.txtCompanyZip)><B>" & _
      COMPANY_ZIP_LABEL & _ 
      "</B></A> -- required field."
  ElseIf (Len(m_sCompanyZip) > zipMaxLength) Then
    sErrMsg = sErrMsg & _ 
      "<A HREF=javascript:fnFieldFocus(document.frmApplication.txtCompanyZip)><B>" & _
      COMPANY_ZIP_LABEL & _
      "</B></A> -- max length is " & zipMaxLength & " characters."
  ElseIf Not iUtils_validZip("US", m_sCompanyZip) Then
    sErrMsg = sErrMsg & _
      "<A HREF=javascript:fnFieldFocus(document.frmApplication.txtCompanyZip)><B>" & _
      COMPANY_ZIP_LABEL & _ 
      "</B></A> -- incorrect format."
  End If

  ValidateZip_VerraStyle = sErrMsg
End Function

Sub PrintPOSTSummary() 
  WriteInDiv "POST REQUEST VALUES:"
  WriteFormFieldValue COMPANY_NAME_LABEL, m_sCompanyName
  WriteFormFieldValue COMPANY_EMAIL_LABEL, m_sCompanyEmail
  WriteFormFieldValue COMPANY_ZIP_LABEL, m_sCompanyZip
  WriteFormFieldValue COMPANY_IS_NICE_LABEL, m_sCompanyIsNice
End Sub

Sub WriteFormFieldValue(fieldName, fieldValue)
  Response.Write("<div>")
  Response.Write(fieldName & ": " & fieldValue)
  Response.Write("</div>")
End Sub 

Sub WriteInDiv(text)
  Response.Write("<div>")
  Response.Write(text)
  Response.Write("</div>")
End Sub 

 %>

