#tag Module
Protected Module StringExtensions
	#tag Method, Flags = &h0
		Function ContainsNumbers(extends s as string) As Boolean
		  For Each c As String In s.Characters
		    If c.IsNumeric Then
		      Return True
		    End
		  Next
		  Return False
		End Function
	#tag EndMethod


End Module
#tag EndModule
