#tag Class
Protected Class ComponentModel
Inherits JsonModelBase
	#tag Property, Flags = &h0
		CurrentValue As Variant
	#tag EndProperty

	#tag Property, Flags = &h0
		DisplayName As String
	#tag EndProperty

	#tag Property, Flags = &h0
		DisplayOrder As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		DisplayUnit As String
	#tag EndProperty

	#tag Property, Flags = &h0
		FirstReceivedTs As DateTime
	#tag EndProperty

	#tag Property, Flags = &h0
		HardwareId As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Id As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		LastReceivedTs As DateTime
	#tag EndProperty

	#tag Property, Flags = &h0
		MaxValue As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		MinValue As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		ShortName As String
	#tag EndProperty

	#tag Property, Flags = &h0
		StationUid As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Type As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Select Case Self.Type
			    
			  Case "AC"
			    Return Enums.ComponentTypes.Actor
			    
			  Case "FL"
			    Return Enums.ComponentTypes.Fault
			    
			  Case "CO"
			    Return Enums.ComponentTypes.Counter
			    
			  Case "FI"
			    Return Enums.ComponentTypes.FillLevel
			    
			  Case "SE"
			    Return Enums.ComponentTypes.Sensor
			    
			  Case "DI"
			    Return Enums.ComponentTypes.Divider
			    
			  Else
			    Return Enums.ComponentTypes.Undefined
			    
			  End
			End Get
		#tag EndGetter
		Attributes( "#JsonIgnore" ) TypeDef As Enums.ComponentTypes
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Select Case TypeDef
			    
			  Case Enums.ComponentTypes.Actor
			    Return "Aktor"
			    
			  Case Enums.ComponentTypes.Counter
			    Return "Zähler"
			    
			  Case Enums.ComponentTypes.Divider
			    Return "Trenner (UI)"
			    
			  Case Enums.ComponentTypes.Fault
			    Return "Fehler"
			    
			  Case Enums.ComponentTypes.FillLevel
			    Return "Füllstand"
			    
			  Case Enums.ComponentTypes.Sensor
			    Return "Sensor"
			    
			  Else
			    Return "Undefiniert"
			    
			  End
			  
			End Get
		#tag EndGetter
		Attributes( "#JsonIgnore" ) TypeName As String
	#tag EndComputedProperty


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
			Type="String"
			EditorType="MultiLineEditor"
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
			Name="HardwareId"
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
				"0 - Actor"
				"1 - Counter"
				"2 - Sensor"
				"3 - FillLevel"
				"4 - Alert"
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
			Type="Enums.ComponentTypes"
			EditorType="Enum"
			#tag EnumValues
				"0 - Undefined"
				"1 - Actor"
				"2 - Counter"
				"3 - Sensor"
				"4 - FillLevel"
				"5 - Fault"
				"6 - Divider"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="DisplayUnit"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MaxValue"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinValue"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
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
			Name="TypeName"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Id"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
