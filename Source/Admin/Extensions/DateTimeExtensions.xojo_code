#tag Module
Protected Module DateTimeExtensions
	#tag Method, Flags = &h0
		Function AsLongDateString(dt as Datetime) As String
		  If dt = Nil Then
		    Return ""
		  Else
		    Return dt.AsLongDateString
		  end
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AsLongDateString(extends dt as Datetime) As String
		  If dt = Nil Then
		    Return ""
		  Else
		    Return dt.ToString(DateTime.FormatStyles.Long, DateTime.FormatStyles.None)
		  end
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
