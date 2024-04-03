<title>Form validation - one field with multiple inputs</title>
<!-- links to js and css shoul be at the top in order for them to be placed in the head by the browser-->
<!-- <script src="index.js" defer type="module"></script> -->
<link rel="stylesheet" href="style.css" />
<!-- end of links -->

<!-- includes for asp with code here -->

<!--#include virtual="/Auth/Services/ApxSecurity.inc.asp"-->
<!--#include virtual="/Auth/Services/Authservice.asp"-->
<!--#include virtual="/forms/oneFieldWithMultipleInputs/form.asp"-->

<!-- end of asp includes -->

<!-- asp code here -->
<%
RedirectIfNotLoggedIn
CheckCSRF
%>
<!-- end of asp code-->

<!--#include virtual="/Views/Common/myPageHeader.asp"-->

<%
Const TEST_LABEL = "Test field"

Dim m_iTestCount : m_iTestCount = 0
Dim m_sTest
Dim m_sTestArray

If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
  m_sTest = Request.Form("test")
  m_sTestArray = Split(m_sTest, ", ")
Else
  m_sTestArray = Split(",,,,", ",")
End If
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
  PrintTestFieldPOSTSummary
End If

Sub WriteInDiv(text)
  Response.Write("<div>")
  Response.Write(text)
  Response.Write("</div>")
End Sub

Sub PrintTestFieldPOSTSummary() 

  Dim maxNumberOfTestInputs : maxNumberOfTestInputs = 2
  If UBound(m_sTestArray) > maxNumberOfTestInputs Then
    Response.Write("<div>")
    Response.Write("Too many inputs. The max number is: " & maxNumberOfTestInputs)
    Response.Write("</div>")
  End If

  Response.Write("<div>")
  Response.Write("m_sTestArray size: " & m_iTestCount)
  Response.Write("</div>")
  Response.Write("<div>")
  Response.Write("Ubound m_sTestArray: " & UBound(m_sTestArray))
  Response.Write("</div>")

  Response.Write("<div>")
  Response.Write("Whole " & TEST_LABEL & ": " & m_sTest)
  Response.Write("</div>")

  Dim i
  For i = LBound(m_sTestArray) To UBound(m_sTestArray)
    Response.Write("<div>")
    Response.Write(TEST_LABEL & " " & i & ": " & CStr(m_sTestArray(i)))
    Response.Write("</div>")
  Next
End Sub


%>

