
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>OWASP html helpers</title>
<!-- links to js and css shoul be at the top in order for them to be placed in the head by the browser-->
<link rel="stylesheet" href="../../views/styles/normalize.css" />
<link rel="stylesheet" href="../owasp.css" />

<!-- end of links -->

<!-- includes for asp with code here -->

<!--#include virtual="/Auth/Services/ApxSecurity.inc.asp"-->
<!--#include virtual="/ViewHelpers/htmlHelpers.asp"-->
<!--#include virtual="/Auth/Services/Authservice.asp"-->
<!--#include virtual="Auth/Filters/AuthFilter.asp"-->

<!-- end of asp includes -->

<!-- page header  -->
<!--#include virtual="/Views/Common/myPageHeader.asp"-->

<!-- content wrapper -->
<div class="wrapper">
  <main class="main">
    <section class="section--main">
      <!-- main page content here -->
      <div>Main page</div>

      <div>
        <div>
          Form with a hidden FormCsrfHiddenInput
        </div>
        <form method="post" id=form1 name=form1 onSubmit="" accept-charset="UTF-8">
          <% FormCsrfHiddenInput %>
          <%
          Dim company_url
          company_url = "'/> <script language='javascript'>console.log(document.querySelector('#ahID_encoded').value)</script>"
          %>
          <!--
          <input type="text" name="CompanyUrl" value ='<%=Reform.HtmlAttributeEncode(company_url)%>'>
          -->
          <!--
          company_url contains js script which is injected below into the page
          -->
          <%
          HTMLHelper.InputHidden "hiddenInpt", 1
          HTMLHelper.TextBox "CompanyUrl", company_url
          HTMLHelper.TextBoxReadonly "CompanyUrl", company_url
          HTMLHelper.CheckBox "sampleChkBox", True
          %>
        </form>
      </div>
    </section>
  </main>
</div>