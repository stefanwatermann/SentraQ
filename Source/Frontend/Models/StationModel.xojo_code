#tag Class
Protected Class StationModel
Inherits JsonModelBase
	#tag Property, Flags = &h0
		Components() As ComponentModel
	#tag EndProperty

	#tag Property, Flags = &h0
		DisplayColor As String
	#tag EndProperty

	#tag Property, Flags = &h0
		DisplayName As String
	#tag EndProperty

	#tag Property, Flags = &h0
		DisplayOrder As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		HasActiveAlert As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		Location As Geolocation
	#tag EndProperty

	#tag Property, Flags = &h0
		Attributes( "#JsonIgnore" ) MapViewLocation As WebMapLocation
	#tag EndProperty

	#tag Property, Flags = &h0
		ShortName As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Type As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Select Case Self.Type
			    
			  Case "WA"
			    Return Enums.StationTypes.Waterstation
			    
			  Case "PU"
			    Return Enums.StationTypes.Pumpstation
			    
			  Case "SE"
			    Return Enums.StationTypes.SewageStation
			    
			  Else
			    Return Enums.StationTypes.Undefined
			    
			  End
			End Get
		#tag EndGetter
		Attributes( "#JsonIgnore" ) TypeDef As Enums.StationTypes
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Select Case TypeDef
			    
			  Case Enums.StationTypes.Pumpstation
			    Return "Pumpstation"
			    
			  Case Enums.StationTypes.SewageStation
			    Return "Abwasserstation"
			    
			  Case Enums.StationTypes.Waterstation
			    Return "Wasserwerk"
			    
			  Else
			    Return "Undefiniert"
			    
			  End
			  
			End Get
		#tag EndGetter
		Attributes( "#JsonIgnore" ) TypeName As String
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Uid As String
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
			Name="DisplayName"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Uid"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DisplayColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Type"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="Enum"
			#tag EnumValues
				"0 - Waterstation"
				"1 - Pumpstation"
				"2 - SewageStation"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="ShortName"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TypeDef"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Enums.StationTypes"
			EditorType="Enum"
			#tag EnumValues
				"0 - Undefined"
				"1 - Waterstation"
				"2 - Pumpstation"
				"3 - SewageStation"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="DisplayOrder"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasActiveAlert"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TypeName"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
