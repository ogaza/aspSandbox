<title>Form validation</title>
<!-- links to js and css shoul be at the top in order for them to be placed in the head by the browser-->
<script src="index.js" defer type="module"></script>
<link rel="stylesheet" href="form.css" />
<!-- end of links -->

<script language="javascript">
  function fnFieldFocus(formFileld)
  {
    formFileld.focus();
  }
</script>

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
Dim zipMaxLength : zipMaxLength = 8

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

  Dim validationResults
  validationResults = Array(ValidateEmail, ValidateZip)

  WriteInDiv "VALIDATION RESULT:"
  Dim validationResult
  Dim i
  For i = 0 To UBound(validationResults)
    validationResult = validationResults(i)
    Dim fieldName : fieldName = validationResult(0)
    Dim fieldLabel : fieldLabel = validationResult(1)
    Dim errors : errors = validationResult(2)
    ' print validation results as html
    RenderFieldValidationResult fieldName, fieldLabel, errors
  Next

End If

Function ValidateEmail()
  ReDim validationErrors(2)

  If Not RequiredFieldProvided(m_sCompanyEmail) Then
    validationErrors(0) = "Value is required"
  End IF

  If Not EmailHasValidFormat(m_sCompanyEmail) Then
    validationErrors(1) = "Wrong format"
  End IF

  If Not HasMaxLengthOf(m_sCompanyEmail, emailMaxLength) Then
    validationErrors(2) = "Cannot have more than " & emailMaxLength & " charcters" 
  End IF

  ValidateEmail = Array("companyEmail", COMPANY_EMAIL_LABEL, validationErrors)
End Function

Function ValidateZip()
  ReDim validationErrors(1)

  If Not RequiredFieldProvided(m_sCompanyZip) Then
    validationErrors(0) = "Value is required"
  End IF

  If Not HasMaxLengthOf(m_sCompanyZip, zipMaxLength) Then
    validationErrors(1) = "Cannot have more than " & zipMaxLength & " charcters" 
  End IF

  ValidateZip = Array("companyZip", COMPANY_ZIP_LABEL, validationErrors)
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

