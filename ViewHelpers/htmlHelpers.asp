
<% 
class HTMLHelperClass
%>
  <%
  Function TextBox(name, value)
    Call TextBoxBase(name, value, False)
  End Function
  %>

  <%
  Function TextBoxReadonly(name, value)
    Call TextBoxBase(name, value, True)
  End Function
  %>

  <%
  Function TextBoxBase(name, value, readonly)
  %>
    <input 
      <%
      ' type=hidden 
      Dim nameEncoded
      nameEncoded = Reform.HtmlAttributeEncode(name)
      %>
      id="<%=nameEncoded%>"
      name="<%=nameEncoded%>"
      value="<%=Reform.HtmlAttributeEncode(value)%>"
      <%
      If readonly Then
      %>
      readonly
      <%
      End If
      %>
    >
  <%
  End Function
  %>

  <%
  Function CheckBox(name, checked)
  %>
    <input 
      type="checkbox" 
      <%
      Dim nameEncoded
      nameEncoded = Reform.HtmlAttributeEncode(name)
      %>
      id="<%=nameEncoded%>"
      name="<%=nameEncoded%>"
      <%If checked = True Then%> 
      checked 
      <%End If%> 
      value="1">
  <%
  End function
  %>

  <%
  Function InputHidden(name, value)
    Call InputBase("hidden", name, value, False)
  End Function
  %>

  <%
  Function InputBase(inputType, name, value, readonly)
  %>
    <input
      type="<%=inputType%>"
      <%
      Dim nameEncoded
      nameEncoded = Reform.HtmlAttributeEncode(name)
      %>
      id="<%=nameEncoded%>"
      name="<%=nameEncoded%>"
      value="<%=Reform.HtmlAttributeEncode(value)%>"
      <%
      If readonly Then
      %>
      readonly
      <%
      End If
      %>
    >
  <%
  End Function
  %>
<%
end class
%>

<%
Dim HTMLHelper
Set HTMLHelper = new HTMLHelperClass
%>