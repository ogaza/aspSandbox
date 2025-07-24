
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
Dim queryParamHtml, queryParamHtmlAttribite
queryParamHtml = Request.QueryString("queryParamHtml")
queryParamHtml = Reform.HtmlEncode(queryParamHtml)

queryParamHtmlAttribite = Request.QueryString("queryParamHtmlAttribite")
queryParamHtmlAttribite = Reform.HtmlAttributeEncode(queryParamHtmlAttribite)

Function DisplayRequestData()
%>
<div class="request-data-summary">
  <div class="summary-item">
    <div>
      queryParam as html:
    </div>
    <div>
      <%=queryParamHtml%>
    </div>
  </div>
  <div class="summary-item">
    <div>
      queryParam as text input value:
    </div>
    <div>
      <input type="text" name="queryParamHtmlAttribite" value="<%=queryParamHtmlAttribite%>" />
    </div>
  </div>
</div>
<%
End Function
%>
<!-- end of asp code-->

<!-- page header  -->
<!--#include virtual="/Common/Views/myPageHeader.asp"-->

<!-- content wrapper -->
<div class="wrapper">
  <main class="main">
    <section class="section--main">
      <%
      DisplayRequestData
      %>
    </section>
  </main>
</div>

