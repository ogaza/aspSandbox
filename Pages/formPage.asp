
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>View Holepers</title>
<!-- links to js and css shoul be at the top in order for them to be placed in the head by the browser-->
<link rel="stylesheet" href="../common/styles/normalize.css" />
<link rel="stylesheet" href="../common/styles/index.css" />

<!-- end of links -->

<!-- includes for asp with code here -->

<!--#include virtual="/include/ApxSecurity.inc.asp"-->
<!--#include virtual="/Auth/Services/AuthService.asp"-->

<!-- end of asp includes -->

<!-- asp code here -->
<%
' RedirectIfNotLoggedIn
%>

<%
Dim hdnField, txtInpt

hdnField = Request.Form("hdnField")
txtInpt = Request.Form("txtInpt")
%>
<!-- end of asp code-->

<!-- page header  -->
<!--#include virtual="/Common/Views/myPageHeader.asp"-->


<!-- content wrapper -->
<div class="wrapper">
  <main class="main">
    <section class="section--main">
      <!-- main page content here -->
      <div>
        Main page
      </div>
      <div>
        <%
        DisplayForm
        %>
      </div>
    </section>
  </main>
  <%
  DisplayRequestData
  %>
</div>

<%
Function DisplayForm()
%>

<form id="myForm" name="myForm" method="POST">
  <%
  FormCsrfHiddenInput
  %>
  <input type="hidden" name="hdnField" value="<%=Reform.HtmlAttributeEncode(hdnFieldValue)%>" />

  <div class="form-item">
    <div class="form-item__label">
      Enter text value
    </div>
    <div class="form-item__input">
      <input type="text" name="txtInpt" value="<%=Reform.HtmlAttributeEncode(txtInpt)%>" />
    </div>
  </div>
  <button type="submit">Submit</button>
</form>

<%
End Function

Function DisplayRequestData()
%>
<div class="request-data-summary">
  <div class="summary-item">
    <div>
      hdnField:
    </div>
    <div>
      <%=Reform.HtmlEncode(txtInpt)%>
    </div>
  </div>
  <div class="summary-item">
    <div>
      txtInpt in an input:
    </div>
    <div>
      <input type="text" name="txtInpt_display" value="<%=Reform.HtmlEncode(hdnField)%>" />
    </div>
  </div>
</div>
<%
End Function
%>
