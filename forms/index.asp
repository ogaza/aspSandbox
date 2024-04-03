<title>Form validation</title>
<!-- links to js and css shoul be at the top in order for them to be placed in the head by the browser-->
<!-- <script src="index.js" defer type="module"></script> -->
<link rel="stylesheet" href="index.css" />
<!-- end of links -->

<!-- includes for asp with code here -->

<!--#include virtual="/Auth/Services/ApxSecurity.inc.asp"-->
<!--#include virtual="/Auth/Services/Authservice.asp"-->

<!-- end of asp includes -->

<!-- asp code here -->
<%
RedirectIfNotLoggedIn
CheckCSRF
%>
<!-- end of asp code-->

<!--#include virtual="/Views/Common/myPageHeader.asp"-->

<%

%>

<!-- content wrapper -->
<div class="wrapper">
  <main class="main">
    <section class="section--main">
      <!-- main page content here -->
      <h2>
        Form examples
      </h2>
      <ul>
        <li>
          <a href="./newConcept">new concept of forms in asp</a>
        </li>
        <li>
          <a href="./oneFieldWithMultipleInputs">one field with many inputs</a>
        </li>
        <li>
          <a href="./verraStyle">verra style form</a>
        </li>
      </ul>
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

Sub WriteInDiv(text)
  Response.Write("<div>")
  Response.Write(text)
  Response.Write("</div>")
End Sub
%>

