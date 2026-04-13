#tag Class
Protected Class MapStation
	#tag Method, Flags = &h0
		Sub Constructor(station as StationModel, location as WebMapLocation)
		  Self.Station = station
		  Self.MapLocation = location
		  self.LastFaultValue = station.HasFaults
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Self.Station <> Nil Then
			    If Self.Station.HasFaults Then
			      Return"Stoerung in " + Self.Station.DisplayNameAscii
			    Else
			      Return Self.Station.DisplayNameAscii
			    End
			  End
			End Get
		#tag EndGetter
		DisplayTitle As String
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		LastFaultValue As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		MapLocation As WebMapLocation
	#tag EndProperty

	#tag Property, Flags = &h0
		Station As StationModel
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
			Name="LastFaultValue"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
