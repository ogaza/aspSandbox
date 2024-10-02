<%
class HtmlHelpers

  Function ActionLink(href, label)
    ' dim hrefEncoded : hrefEncoded = Server.URLEncode(href)
  %>

    <a href="<%=Reform.HtmlAttributeEncode(href)%>">
      <%=Reform.HtmlEncode(label)%>
    </a>
  <%
  End Function

  Function TextBox(name, value, disabled)
  %>
    <input 
      type="textbox"
      name="<%=Reform.HtmlAttributeEncode(name)%>" 
      value="<%=Reform.HtmlAttributeEncode(value)%>"
      <%
      If disabled Then
      %>
      disabled
      <%
      End If
      %>
    >
  <%
  End Function

  Function TextArea()
  %>
    <input type="textarea">
  <%
  End Function
  
  Function CheckBox()
  %>
    <input type="checkbox">
  <%
  End Function

  Function RadioButton()
  %>
    <input type="radio">
  <%
  End Function
  
  Function DropDownList()
  %>
    <select>
      <option>
    </select>
  <%
  End Function

  Function Hidden(name, value)
  %>
    <input 
      type="hidden"
      name="<%=Reform.HtmlAttributeEncode(name)%>" 
      value="<%=Reform.HtmlAttributeEncode(value)%>"
    >
  <%
  End Function

  Function Display(text)
  %>
    <%=Reform.HtmlEncode(text)%>
  <%
  End Function

  Function Label()
  %>
    <label>
  <%
  End Function

  Function Password()
  %>
    <input type="password">
  <%
  End Function

  Function Button(name, value, onClick)
  %>
    <INPUT 
      type="button" 
      name="<%=Reform.HtmlAttributeEncode(name)%>" 
      value="<%=Reform.HtmlAttributeEncode(value)%>"
      onClick="<%=Reform.HtmlAttributeEncode(onClick)%>"
    >
  <%
  End Function

  Function Submit(name, value, onClick, disabled)
  %>
    <INPUT 
      type="submit" 
      name="<%=Reform.HtmlAttributeEncode(name)%>" 
      value="<%=Reform.HtmlAttributeEncode(value)%>"
      onClick="<%=Reform.HtmlAttributeEncode(onClick)%>"
      <%
      If disabled <> "" Then
      %>
      disabled
      <%
      End If
      %>
    >
  <%
  End Function

End class