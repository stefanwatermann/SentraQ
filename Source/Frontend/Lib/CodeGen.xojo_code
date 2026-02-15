#tag Module
 Attributes ( "@Guid" = "64D978BF-82DA-4D03-BC81-819913C8B51A", "@Author" = "Stefan Watermann", "@Category" = "Helper", "@Description" = "Generates random codes of individual length.", "@Copyright" = "(c) 2025 Stefan Watermann", "@Version" = "1.0.0" ) Protected Module CodeGen
	#tag Method, Flags = &h0
		Function GenerateCode(length as integer = 8, numbersOnly as boolean = false) As string
		  Var c As String = "ABCDEFGHKLMNPQRTUWXYZ123456789"
		  
		  If numbersOnly Then
		    c = "1234567890"
		  End
		  
		  Var p As String
		  
		  For a As Integer = 0 To length - 1
		    Var i As Integer = System.Random.InRange(0, c.Length-1)
		    p = p + c.Middle(i, 1)
		  Next
		  
		  Return p
		End Function
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
