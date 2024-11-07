<%
Function GetSearchParamDefinitions()

  ReDim searchParamNames(2)

  searchParamNames(0) = "CategoryID"
  searchParamNames(1) = "CategoryName"
  searchParamNames(2) = "Description"

  ReDim searchParamTypes(2)

  searchParamTypes(0) = adInteger
  searchParamTypes(1) = adVarChar
  searchParamTypes(2) = adVarChar

  ReDim searchParamSizes(2)

  ' searchParamSizes(0)  - empty for adInteger
  searchParamSizes(0) = 4
  searchParamSizes(1) = 100
  searchParamSizes(2) = 100

  ReDim arr(2)
  Dim item
  Dim searchParamName, i : i = 0

  For Each searchParamName in searchParamNames
    
    Set item = New TableColumn
    item.Name = searchParamNames(i)
    item.ColumnType = searchParamTypes(i)
    item.Size = searchParamSizes(i)

    Set arr(i) = item

    i = i + 1
  Next

  GetSearchParamDefinitions = arr

End Function

Function GetSearchParamValuesFromForm(ByRef arr)

  Dim item, i : i = 0

  For Each item in arr
    Dim value : value = Request.Form(item.Name)

    If value <> "" Then
      item.Value = value
    End If
  Next

End Function
%>