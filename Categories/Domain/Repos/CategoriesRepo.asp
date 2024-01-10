<!--#include virtual="/DB/iDBPointer.asp"-->
<!--#include virtual="Categories/Domain/Entities/Category.asp"-->
<%
  Function GetCategory(categoryId)

    Dim conn
    Set conn = Server.CreateObject("ADODB.Connection")
    conn.Open(DefaultDatabase)

    Dim sql : sql = "sp_GetCategory"
    Dim cmd : Set cmd = Server.CreateObject("ADODB.Command")
    cmd.ActiveConnection = conn
    
    cmd.CommandText = sql
    cmd.CommandType = adCmdStoredProc
    cmd.Parameters.Append cmd.CreateParameter("@categoryId", adInteger, adParamInput, , categoryId)


    Dim list
    Set list = CreateObject("System.Collections.ArrayList")

    Dim rs : Set rs = cmd.Execute
    Do While Not rs.EOF
      list.Add((New Category).Init(rs(0), rs(1), rs(2)))

      rs.MoveNext 
    Loop 

    rs.Close
    Set rs = Nothing
    conn.Close
    Set conn = Nothing

    Set GetCategory = list(0)
  End Function

  Function GetCategories()

    Dim conn
    Set conn = Server.CreateObject("ADODB.Connection")
    conn.Open(DefaultDatabase)

    Dim sql : sql = "SELECT CategoryID, CategoryName, Description FROM dbo.Categories"
    Dim cmd : Set cmd = Server.CreateObject("ADODB.Command")
    cmd.ActiveConnection = conn
    
    cmd.CommandText = sql
    cmd.CommandType = adCmdText

    Dim list
    Set list = CreateObject("System.Collections.ArrayList")

    Dim rs : Set rs = cmd.Execute
    Do While Not rs.EOF
      list.Add((New Category).Init(rs(0), rs(1), rs(2)))
      rs.MoveNext 
    Loop 

    rs.Close
    Set rs = Nothing
    conn.Close
    Set conn = Nothing

    Set GetCategories = list
  End Function
%>