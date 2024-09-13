<title>ASP Sandbox</title>
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
    </section>

    <div>
    <%
    On Error Resume Next

    Dim utils : Set utils = Server.CreateObject("WebUtils.myWebUtils")

    Dim StartProgramDate
    StartProgramDate = "1/1/2016"

    Dim m_sStartDate
    m_sStartDate = "18.02.2022"
    ' m_sStartDate = "18/02/2022"

    Dim m_sStartDate_formatted
    m_sStartDate_formatted = utils.vbFormat(m_sStartDate, "dd\/mm\/yyyy")

    Response.Write("m_sStartDate: " & m_sStartDate & "</br>")
    Response.Write("m_sStartDate_formatted: " & m_sStartDate_formatted & "</br>")

    If CDate(m_sStartDate_formatted) < CDate(StartProgramDate) Then
      Response.Write(m_sStartDate & " < " & StartProgramDate)
    Else
      Response.Write(m_sStartDate & " >= " & StartProgramDate)
    End If

    Set utils = Nothing 
    %>
    </div>

  </main>
</div>
