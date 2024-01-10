<%
  Class Category
    Public Function Init(id, name, description)
      strId = id
      strName = name
      strDescription = description

      Set Init = Me
    End Function

    Private strId
    Public Property Get Id()
      Id = strId
    End Property

    Private strName
    Public Property Get Name()
      Name = strName
    End Property

    Private strDescription
    Public Property Get Description()
      Description = strDescription
    End Property

    Private Sub Class_Terminate()
    End Sub
  End Class
  
%>