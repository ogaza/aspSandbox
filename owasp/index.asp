
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

      <div class="divider-64">
      </div>

      <div>
        <a href="https://cheatsheetseries.owasp.org/cheatsheets/Cross_Site_Scripting_Prevention_Cheat_Sheet.html">
          OWASP - Cross Site Scripting Prevention Cheat Sheet
        </a>
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
            <!--
            here we can see how Reform.HTMLEncode can break the desired behaviour
            do not use it if you actually want to generate html
             -->
            <%=Reform.HTMLEncode(msg)%>
          </div>
        </div>

        <div class="row">
          <div>
            <!--
            here we can see an example of basic script injection
             -->
            <%
            Dim m_sAction : m_sAction = "<script language='javascript'>console.log('m_sAction')</script>"
            ' Dim m_sAction : m_sAction = "<script language='javascript'>alert('test')</script>"
            Response.Write("""" & m_sAction & """ is an unknown Action!")
            %>
          </div>
          <div>
            <!--
            and here we can see how Reform.HtmlEncode prevents a basic script injection
             -->
            <%
            ResponseWriteUnsafe("""" & Reform.HtmlEncode(m_sAction) & """ is an unknown Action!")
            %>
          </div>
        </div>

        <div class="row">
          <%
          Dim company_info(1)
          company_info(0) = "<script language='javascript'>console.log('company_info')</script>"
          company_info(1) = "just regular text"
          %>
          <!--
            here we can see another example of basic script injection
            its almost the same as the previous one
            but here we are using a local variable in form of table
          -->
          <div>
            <%=company_info(0)%>
            <%=company_info(1)%>
          </div>
          <div>
            <%=Reform.HtmlEncode(company_info(0))%>
            <%=Reform.HtmlEncode(company_info(1))%>
          </div>
        </div>
      </div>

    </section>
  </main>
</div>
