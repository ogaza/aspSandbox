<%

Function InputIsNumeric(param)

  InputIsNumeric = IsNumeric(param)

End Function

Function IsAlphaNumeric(ByRef param)

  IsAlphaNumeric = False

  Dim pattern
  pattern = "^([\w]+)$"

  IsAlphaNumeric = InputMatchesPattern(param, pattern)

End Function

Function IsEmptyString(param)
  IsEmptyString = True

  If param <> "" Then
    IsEmptyString = False
  End If

End Function

Function IsNullOrEmpty(ByRef param)

  IsNullOrEmpty = IsNull(param) Or IsEmpty(param)

End Function

Function InputIsSafeString(ByRef param)
End Function

Function InputIsPositiveInteger(param)

  InputIsPositiveInteger = False

  Dim pattern
  pattern = "^([\d]+)$"

  InputIsPositiveInteger = InputMatchesPattern(param, pattern)

End Function

Function InputIsListOfIds(ByRef param)

  InputIsListOfIds = False

  Dim pattern
  pattern = "^(([\d]+)([,]{0,1}))+$"

  InputIsListOfIds = InputMatchesPattern(param, pattern)

End Function

Function IsEmailAddress(ByRef param)

  IsEmailAddress = False

  Dim pattern
  pattern = "^$|^[0-9a-zA-Z]+[0-9a-zA-Z\\+\-_\\.\\&\\#/]*[0-9a-zA-Z]+@[0-9a-zA-Z\\-]+[\\.]{1}[0-9a-zA-Z\\-\\.]*[0-9a-zA-Z]+$"
  ' pattern = "^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$"

  IsEmailAddress = InputMatchesPattern(param, pattern)

End Function

Function InputMatchesPattern(ByRef inputParam, pattern)

  InputMatchesPattern = False

  Dim RegEx : Set RegEx = New RegExp
  RegEx.Pattern = pattern

  Dim isMatch
  isMatch = RegEx.Test(inputParam)

  InputMatchesPattern = isMatch

   Set RegEx = Nothing

End Function

Function GetRegExMatchesFromString(str, pattern)

  Dim RegEx : Set RegEx = New RegExp
  RegEx.Pattern = pattern

  ' Dim matches, match

  Set matches = RegEx.Execute(inputParam)
  Set GetRegExMatchesFromString = matches

  ' Response.Write "Found " & matches.Count & " matches<br/>"
  ' If matches.Count > 0 Then
  ' For Each match In matches
  '   Response.Write "match value: " & match.Value & "<br/>"
  ' Next
  ' End If

  Set RegEx = Nothing

End Function

Function CheckIsOneOfTheList(ByRef sParameter, slist)

  If IsEmpty(sParameter) OR sParameter = "" Then
   exit Function
  End If

  Dim isValid
  isValid = StringValueIsOnTheList(sParameter, Split(slist,","))

  If (Not isValid) Then
    Call HandleUnsafeStringParameter_v2(sParameter)
  End If

End Function

Function StringValueIsOnTheList(val, list)
  StringValueIsOnTheList = False

  Dim valLCase
  valLCase = LCase(val)

  Dim listItem
  For Each listItem in list
    StringValueIsOnTheList = (valLCase = LCase(listItem))
    ' StringValueIsOnTheList = (InStr(valLCase, listItem) <> 0)
    If StringValueIsOnTheList Then
      Exit Function
    End If
  Next
End Function
%>