<title>Form validation - verra style</title>
<!-- links to js and css shoul be at the top in order for them to be placed in the head by the browser-->

<!-- this is added to myPageHeader so no need to include it ia any given page  -->
<link rel="stylesheet" href="index.css" />
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
<!--#include virtual="/forms/verraStyle/form.asp"-->
<!--#include virtual="/forms/verraStyle/validation.asp"-->

<!-- end of asp includes -->

<!-- asp code here -->
<%
RedirectIfNotLoggedIn
CheckCSRF
%>
<!-- end of asp code-->

<!--#include virtual="/Views/Common/myPageHeader.asp"-->

<%
Const COMPANY_ZIP_LABEL = "Company ZIP Code"
Dim m_sCompanyZip
Dim zipMaxLength : zipMaxLength = 8

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
  Dim validationResult : validationResult = ValidateZip_VerraStyle
  WriteInDiv validationResult
End If

Sub PrintPOSTSummary() 
  WriteInDiv "POST REQUEST VALUES:"
  WriteFormFieldValue COMPANY_ZIP_LABEL, m_sCompanyZip
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

