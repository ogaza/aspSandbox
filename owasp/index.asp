
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>OWASP Sandbox</title>
<!-- links to js and css shoul be at the top in order for them to be placed in the head by the browser-->
<link rel="stylesheet" href="../views/styles/normalize.css" />
<link rel="stylesheet" href="owasp.css" />

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

      <div class="divider-64">
      </div>

      <div>
        <%
        Dim msg : msg = "<font face='arial' size=2 color='#ff0000'>some message here</font>"
        %>

        <div class="row">
          <div>
            <code>
              Text
            </code>
            as plain html
          </div>
          <div>
            <code>
              Reform.HTMLEncode(Text)
            </code>
          </div>
        </div>

        <div class="divider">
        </div>
        
        <div class="row">
          <div>
            <%=msg%>
          </div>
          <div>
            <%=Reform.HTMLEncode(msg)%>
          </div>
        </div>
      </div>

      <div class="divider-64">
      </div>

      <div>
        <div>
          Form with a hidden FormCsrfHiddenInput
        </div>
        <form method="post" id=form1 name=form1 onSubmit="" accept-charset="UTF-8">
          <% FormCsrfHiddenInput %>
          <input type="text">
        </form>
      </div>
    </section>
  </main>
</div>
