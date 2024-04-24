
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>OWASP Show Alert</title>
<!-- links to js and css shoul be at the top in order for them to be placed in the head by the browser-->
<link rel="stylesheet" href="../../views/styles/normalize.css" />
<link rel="stylesheet" href="../owasp.css" />

<!-- end of links -->

<!-- includes for asp with code here -->

<!--#include virtual="/Auth/Services/ApxSecurity.inc.asp"-->
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
        <%
        ' the following code will display alert modal 
        ' Reform.HTMLEncode will change the script tag into regular string 
        ' preventing from possible js injection through the m_sError variable
        
        Dim m_sError : m_sError = "error message"
        ResponseWriteUnsafe ("<script language=""javascript"">")
        ' ResponseWriteUnsafe ("window.history.back();")
        ResponseWriteUnsafe ("alert(""" & Reform.JsString(m_sError) & """);")
        ResponseWriteUnsafe ("</script>")
        %>
      </div>
    </section>
  </main>
</div>
