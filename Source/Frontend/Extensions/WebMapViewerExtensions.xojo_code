#tag Module
Protected Module WebMapViewerExtensions
	#tag Method, Flags = &h0
		Function GetLocationByStationsUid(extends mapViewer as WebMapViewer, uid as string) As WebMapLocation
		  For i As Integer = 0 To mapViewer.LocationCount - 1
		    Var location As WebMapLocation = mapViewer.LocationAt(i)
		    If location.Tag = uid Then
		      Return location
		    end
		  Next
		  
		  Return Nil
		End Function
	#tag EndMethod


End Module
#tag EndModule
