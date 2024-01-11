<title>Form validation</title>
<!-- links to js and css shoul be at the top in order for them to be placed in the head by the browser-->
<script src="index.js" defer type="module"></script>
<link rel="stylesheet" href="form.css" />
<!-- end of links -->

<!-- includes for asp with code here -->

<!--#include virtual="/Auth/Services/ApxSecurity.inc.asp"-->
<!--#include virtual="/Auth/Services/Authservice.asp"-->
<!--#include virtual="/forms/form.asp"-->
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
Const COMPANY_EMAIL_LABEL = "Organization Email"

Dim name
Dim soberity
Dim isSober
Dim m_sCompanyEmail
Dim emailMaxLength : emailMaxLength = 12


name = Request.Form("name")
soberity = Request.Form("soberity")
isSober = soberity = "on"
m_sCompanyEmail = trim(Request.Form("email"))
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

  Dim emailValidationResult
  emailValidationResult = ValidateEmail()

  WriteInDiv "EMAIL VALIDATION RESULTS"
  Dim i
  For i = 0 To UBound(emailValidationResult)
    If emailValidationResult(i) <> "" Then
      WriteInDiv emailValidationResult(i)
    End If
  Next
  WriteInDiv "VALIDATION RESULTS END"

  ' Dim validationMsg : validationMsg = ValidateForm
  ' WriteInDiv validationMsg

  ' ' further validation
  ' ' name
  ' WriteInDiv "" & _
  '   "name provided: " & _
  '   RequiredFieldProvided(name)
  ' ' email
  ' WriteInDiv "" & _
  '   "email shorter than " & emailMaxLength & ": " & _ 
  '   HasMaxLengthOf(m_sCompanyEmail, emailMaxLength)
  ' WriteInDiv "" & _
  '   "email has a correct format: " & _ 
  '   EmailHasValidFormat(m_sCompanyEmail)
  ' WriteInDiv "" & _
  '   "email provided: " & _
  '   RequiredFieldProvided(m_sCompanyEmail)
End If

Function ValidateEmail() 
  ' Dim i
  ReDim validators(1)

  If Not EmailHasValidFormat(m_sCompanyEmail) Then
    validators(0) = "Email has wrong format"
  End IF

  If Not HasMaxLengthOf(m_sCompanyEmail, emailMaxLength) Then
    validators(1) = "Email cannot have more than " & emailMaxLength & " charcters" 
  End IF

  ValidateEmail = validators
  
  ' Dim d
  ' Set d = Server.CreateObject("Scripting.Dictionary")
  ' d.Add "email", validators

  ' For i = 0 To UBound(validators)
  '   values_accountIds(i) = accouintIds(i)
  ' Next

  ' Dim arr : arr = d.Item("email")
  ' Response.Write("Arr is: " & arr(1))

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

Sub PrintPOSTSummary() 
  WriteInDiv "POST REQUEST VALUES:"
  WriteFormFieldValue "name", name
  WriteFormFieldValue "is sober", isSober
  WriteFormFieldValue "email", m_sCompanyEmail
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

