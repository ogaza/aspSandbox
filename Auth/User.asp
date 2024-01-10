<%
  Class User
    Public Function Init(id, passwordHash, password)
      strId = id
      strPasswordHash = passwordHash
      strPassword = password

      Set Init = Me
    End Function

    Private strId
    Public Property Get Id()
      Id = strId
    End Property

    Private strPasswordHash
    Public Property Get PasswordHash()
      PasswordHash = strPasswordHash
    End Property

    Private strPassword
    Public Property Get Password()
      Password = strPassword
    End Property

    Private Sub Class_Terminate()
    End Sub
  End Class
  
%>