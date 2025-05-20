
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
Function SelectOption(name, options)
  %>
  <select name="<%=name%>">
  <%
  Dim i
  For i = 0 to UBound(options)

  %>
    <option
      id="<%=Reform.HtmlAttributeEncode(options(i, 0))%>"
      value="<%=Reform.HtmlAttributeEncode(options(i, 1))%>"
      <%If options(i, 2) = True Then%>
      selected
      <%End If%>
    >
      <%=Reform.HtmlEncode(options(i, 1))%>
    </option>
  <%
  Next
  %>
  </select>
<%
End Function
%>

<%
Function iUtils_YesNoOption(ByVal sName, _
							ByVal bYes, _
							ByVal sProperty)
%>
			<INPUT type="radio" name="<%=sName%>" value="<%=CStr(True)%>" <%=sProperty%>
			<%If bYes Then%> CHECKED<%End If%>>Yes&nbsp;&nbsp;&nbsp;&nbsp;
			<INPUT type="radio" name="<%=sName%>" value="<%=CStr(False)%>" <%=sProperty%>
			<%If Not bYes Then%> CHECKED<%End If%>>No
<%
End Function
%>

<%
Dim HTMLHelper
Set HTMLHelper = new HTMLHelperClass

Function IterateTwoDimensionalArray(arr)
  Dim i, j
  For i = 0 to UBound(arr)
    For j = 0 to UBound(arr, 2)

      Response.Write(arr(i, j))

    Next
    Response.Write("</br>")
  Next
End Function

%>