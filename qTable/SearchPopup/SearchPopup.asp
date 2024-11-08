<%
Function RenderSearchPopup(tableSearchColumns)
  Dim searchColumn, i
  %>
  <div class="popup-overlay hidden">
    <div class="popup hidden">
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
                <input 
                  type="text" 
                  name="<%=searchColumn.Name%>" 
                  value="" 
                />
              </div>
            </div>
            <%
            Next
            %>
          </div>
          <div class="search__footer">
            <input class="search__submit" type="submit" />
          </div>
        </form>
      </div>
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