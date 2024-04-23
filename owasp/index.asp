<title>OWASP Sandbox</title>
<!-- links to js and css shoul be at the top in order for them to be placed in the head by the browser-->
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
        ' Response.Write("<script language='javascript'>alert('test')</script>")
        ' Reform.HTMLEncode will change the script tag into regular string 
        ' Response.Write(Reform.HTMLEncode("<script language='javascript'></script>"))
        
        ' Dim m_sError : m_sError = "error message"
        ' ResponseWriteUnsafe ("<script language=""javascript"">")
        ' ResponseWriteUnsafe ("window.history.back();")
        ' ResponseWriteUnsafe ("alert(""" & Reform.JsString(m_sError) & """);")
        ' ResponseWriteUnsafe ("</script>")
        %>
      </div>
      <div>
        <%
        Dim msg : msg = "<font face='arial' size=2 color='#ff0000'>some message here</font>"
        %>
        <%=msg%>
        <%=Reform.HTMLEncode(msg)%>
      </div>
      <div>
        <form method="post" id=form1 name=form1 onSubmit="" accept-charset="UTF-8">
          <% FormCsrfHiddenInput %>
          <input type="text">
        </form>
      </div>
    </section>
  </main>
</div>
