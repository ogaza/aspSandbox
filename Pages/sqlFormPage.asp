
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

<!-- end of asp code-->

<!-- page header  -->
<!--#include virtual="/Common/Views/myPageHeader.asp"-->
<!--#include virtual="/include/iUtils.asp"-->


<%
Dim id
id = Request.Form("id")
If id = "" Then id = 0

Call CheckForSafeStringParameterIfNotEmpty(True, id)
%>

<!-- content wrapper -->
<div class="wrapper">
  <main class="main">
    <section class="section--main">
      <div>
        Main page
      </div>
      <div>
        <%
        DisplayForm()
        %>
      </div>
      <div>
        <%
        DisplayData(id)
        %>
      </div>
    </section>
  </main>
</div>

<%
Function DisplayForm()
%>

<form id="myForm" name="myForm" method="POST">

  <% FormCsrfHiddenInput %>

  <div class="form-item">
    <div class="form-item__label">
      Enter id
    </div>
    <div class="form-item__input">
      <input type="text" name="id" value="<%=Reform.HtmlAttributeEncode(id)%>" />
    </div>
  </div>

</form>

<%
End Function
%>

<%
Function DisplayData(id)

  Dim TagDB
  Set TagDB = Server.CreateObject("ADODB.Connection")

  TagDB.ConnectionString = "Provider=SQLNCLI11;Password=!apx52;Persist Security Info=True;User ID=mirecs-webappuser;Initial Catalog=MIRECS-APP-PRE01;Data Source=emregqa-usw-db4"

  ' TagDB.ConnectionString = "Provider=SQLNCLI11;Password=n0write;Persist Security Info=True;User ID=mirecs-publicuser;Initial Catalog=MIRECS-APP-PRE01;Data Source=emregqa-usw-db4"
  TagDB.Open

  Dim sql
  sql = _
  "SELECT TOP 10 " &_
  "  riid " &_
  "FROM " &_
  "  recInfo " &_
  "WHERE " &_
  "  riid = " & id
  ' "  riid = ? "

  Dim cmd
  Set cmd = Server.CreateObject("ADODB.Command")
  cmd.CommandType = adCmdText
  cmd.ActiveConnection = TagDB
  cmd.CommandText = sql

  ' cmd.Parameters.Append cmd.CreateParameter( , adInteger, adParamInput, , id)

  Dim oRs
  Set oRs = Server.CreateObject("ADODB.Recordset")
  oRs.CursorLocation = adUseClient

  On Error Resume Next
  oRs.Open cmd
  On Error Goto 0

  While Not oRs.EOF
    Response.Write("id: " & oRs.Fields.Item(0) & "<br>")

    oRs.MoveNext
  Wend

  oRs.Close
  Set oRs = Nothing

  TagDB.Close
End Function
%>