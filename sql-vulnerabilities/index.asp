
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>SQL Injections Sandbox</title>
<!-- links to js and css shoul be at the top in order for them to be placed in the head by the browser-->
<link rel="stylesheet" href="../views/styles/normalize.css" />
<link rel="stylesheet" href="style.css" />

<!-- end of links -->

<!-- includes for asp with code here -->

<!--#include virtual="/Auth/Services/ApxSecurity.inc.asp"-->
<!--#include virtual="/Auth/Services/Authservice.asp"-->
<!--#include virtual="Auth/Filters/AuthFilter.asp"-->
<!--#include virtual="/DB/iDBPointer.asp"-->

<!-- end of asp includes -->

<!-- asp code here -->
<%
RedirectIfNotLoggedIn
%>
<!-- end of asp code-->

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

      <!-- 
      <div class="divider">
      </div>
      -->
      <!--
      -->
      <div class="row">
        <div>
        SQL
        </div>
        <div>
          <code>
            <%=MultiValued(1, "Additional Project Types", "ProjectTypeDescription", "recProjectTypesXref", "recProjectType", "ProjectType")%>
          </code>
        </div>
      </div>

      <div class="divider">
      </div>
      <!--
      -->

    </section>
  </main>
</div>

<%
Function MultiValued(ByVal id, ByVal name, ByVal field, ByVal table, ByVal refTable, ByVal joinField)

  ' Dim conn
  ' Set conn = Server.CreateObject("ADODB.Connection")
  ' conn.Open(VerraPreDatabase)

  ' Dim cmd : Set cmd = Server.CreateObject("ADODB.Command")
  ' cmd.ActiveConnection = conn

  Dim sql 
  sql = _
			"SELECT r." & field & " " &_
			"FROM " & table & " x " &_
			"INNER JOIN " & refTable & " r ON r." & joinField & " = x." & joinField & " " &_
			"WHERE x.fiID = ?"

  ' cmd.CommandText = sql
  ' cmd.CommandType = adCmdText
  ' cmd.Parameters(0) = "5"

  ' Dim result : result = "Description: "
  ' Dim rs : Set rs = cmd.Execute

  ' Do While Not rs.EOF
  '   result = result & rs.Fields(0).Value
  '   rs.MoveNext 
  ' Loop 

  ' rs.Close
  ' Set rs = Nothing
  ' conn.Close
  ' Set conn = Nothing

  MultiValued = sql
  ' MultiValued = result
End Function
%>
