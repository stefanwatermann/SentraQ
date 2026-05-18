#tag Class
Protected Class AlertModel
Inherits JsonModelBase
	#tag Property, Flags = &h0
		ConfirmedAt As DateTime
	#tag EndProperty

	#tag Property, Flags = &h0
		ConfirmedBy As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Faults As String
	#tag EndProperty

	#tag Property, Flags = &h0
		FirstEventTs As DateTime
	#tag EndProperty

	#tag Property, Flags = &h0
		IsActive As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		LastEventTs As DateTime
	#tag EndProperty

	#tag Property, Flags = &h0
		MailSendAt As DateTime
	#tag EndProperty

	#tag Property, Flags = &h0
		StationUid As String
	#tag EndProperty


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
		#tag ViewProperty
			Name="StationUid"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
