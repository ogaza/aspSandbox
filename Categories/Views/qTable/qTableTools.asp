

<%
Function GetColumnsFrom(oRs)
  Dim idx : idx = 0
  ReDim arr(oRs.Fields.Count - 1)
  Dim item, Field
  For Each Field in oRs.Fields
    Set item = New TableColumn

    item.Name = Field.Name
    item.ColumnType = Field.Type

    Set arr(idx) = item
    idx = idx + 1
  Next

  GetColumnsFrom = arr
End Function
%>

<%
Function RenderSearchPopup(tableSearchColumns)
  Dim searchColumn, i
  %>
  <div id="search-popup" class="popup">
    <div class="popup__header">
      <div class="popup__title">Search</div>
      <div class="popup__close">
        <div role="button" class="popup__button--close">+</div>
      </div>
    </div>
    <div class="popup__content">
      <form class="search__form">
        <div class="search__fields">
        <%
        i = 0
        For Each searchColumn in tableSearchColumns
        %>
          <div class="search__field">
            <div class="search__label">
              <%=searchColumn.Name%>
            </div>
            <div class="search__value">
              <input type="text" name="<%=searchColumn.Name%>" value="" />
            </div>
          </div>
        <%
        Next
        %>
        <div class="search__fields">
      </form>
    </div>
  </div>
<%
End Function
%>

<%
Function RenderSearchColumnsInJS(tableSearchColumns)
  Dim searchColumn, i

  %>
  <script language="javascript">
    var searchFields = new Array(<%=UBound(tableSearchColumns) - 1%>);
  <%
  i = 0
  For Each searchColumn in tableSearchColumns
  %>
    searchFields[<%=i%>] = {
      name : "<%=searchColumn.Name%>",
      type : "<%=searchColumn.ColumnType%>",
    };
  <%
    i = i + 1
  Next
  %>
    // console.log(searchFields);
  </script>
<%
End Function
%>

<%
class TableColumn
  Private m_Name
  Private m_ColumnType
  Private m_Size
  Private m_Relation
  Private m_Value

  Public Property Get Name()
    Name = m_Name
  End Property
  Public Property Let Name(param)
    m_Name = param
  End Property

  Public Property Get ColumnType()
    ColumnType = m_ColumnType
  End Property
  Public Property Let ColumnType(param)
    m_ColumnType = param
  End Property

  Public Property Get Size()
    Size = m_Size
  End Property
  Public Property Let Size(param)
    m_Size = param
  End Property

  Public Property Get Relation()
    Relation = m_Relation
  End Property
  Public Property Let Relation(param)
    m_Relation = param
  End Property

  Public Property Get Value()
    Value = m_Value
  End Property
  Public Property Let Value(param)
    m_Value = param
  End Property
End Class
%>

<%
Function GetMainSql(sql)
  Dim endMark
  Dim i 
  
  endMark = "--DECLARE_END"

  i = InStr(sql, endMark)
  If i Then 
    i = i + Len(endMark)
  Else 
    i = 1 
  End If

  Dim mainSql 
  mainSql = Mid(sql, i)
  'Response.Write("mainSql: </br>" & mainSql & "</br>")

  GetMainSql = mainSql
End Function

Function GetDeclareSql(sql)

  GetDeclareSql = ""

  Dim endMark
  Dim i 
  
  endMark = "--DECLARE_END"

  i = InStr(sql, endMark)
  
  If i Then 
    i = i - 1
  Else 
    Exit Function
  End If

  Dim mainSql 
  mainSql = Mid(sql, 1, i)
  'Response.Write("mainSql: </br>" & mainSql & "</br>") 

  GetDeclareSql = mainSql
End Function

Function Test_GetMainSql()
  Dim sql

  sql = _
  "DECLARE @id INT = ?; " &_
  "--DECLARE_END " & vbCrLf &_
  "SELECT CategoryID, CategoryName, Description FROM dbo.Categories; "

  Response.Write("sql: </br>" & sql & "</br>")
  Response.Write("declareSql: </br>" & GetDeclareSql(sql) & "</br>")
  Response.Write("mainSql: </br>" & GetMainSql(sql) & "</br>")
End Function

%>

