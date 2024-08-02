<%
' Dim className
' className = "DocInfoData"

' ReDim props(16)

' props(0) = "DocId"
' props(1) = "DocFileName"
' props(2) = "DocType"
' props(3) = "DocStatus"
' props(4) = "DocPrivilegeType"
' props(5) = "DocIssueDate"
' props(6) = "DocStartDate"
' props(7) = "DocEndDate"
' props(8) = "DocDateOfFinalIssue	"
' props(9) = "DocIssuanceNum "
' props(10) = "Language "
' props(11) = "ProjectList "
' props(12) = "VersionNumber "
' props(13) = "ProjectOwnerAhID"
' props(14) = "DocumentOwnerAhID"
' props(15) = "ProjectName"
' props(16) = "FiID"

' Call PrintClassScript(className, props)

Function PrintClassScript(className, props)

  Dim prop
  ' ReDim props(16)

  Response.Write("class " & className & "</br>")
  For Each prop In props
    Response.Write("Private m_" & prop & "</br>")
  Next
  Response.Write("</br>")
  For Each prop In props
    Response.Write("Public Property Get " & prop & "() </br>" )
    Response.Write(prop & " = m_" & prop & "</br>")
    Response.Write("End Property </br>")
    Response.Write("Public Property Let " & prop & "(param) </br>" )
    Response.Write("m_" & prop & " = " & "param </br>")
    Response.Write("End Property </br>")
  Next
  Response.Write("End class </br>")
End Function
%>