#tag Module
Protected Module WebMapViewerExtensions
	#tag Method, Flags = &h0
		Function GetLocationByStationsUid(extends mapViewer as WebMapViewer, uid as string) As WebMapLocation
		  For i As Integer = 0 To mapViewer.LocationCount - 1
		    Var location As WebMapLocation = mapViewer.LocationAt(i)
		    If location <> Nil And MapStation(location.Tag).Station.Uid = uid Then
		      Return location
		    end
		  Next
		  
		  Return Nil
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
