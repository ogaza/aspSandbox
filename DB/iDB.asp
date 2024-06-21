<%
Sub DisplaySqlError(ByVal sSql)
%>
  <table>
    <%
    For Each oSqlError In TagDB.Errors
    %>
    <tr>
      <td>
        <%=oSqlError.Description%>
      </td>
    </tr>
    <%
    Next
    %>
  </table>
  <%
  TagDB.Errors.Clear()
  %>
<%
End Sub
%>