#tag Module
Protected Module StationModelExtensions
	#tag Method, Flags = &h0
		Function CreateIcon(Extends station as StationModel) As WebPicture
		  Var w As Integer = 25
		  Var h As Integer = 25
		  
		  Var drawingColor As Color
		  
		  If Not station.DisplayColor.BeginsWith("&c") Then
		    drawingColor = &c02BCF400
		  Else
		    drawingColor  = Color.FromString(station.DisplayColor)
		  End
		  
		  Var p As New Picture(w, h)
		  Var g As Graphics = p.Graphics
		  
		  If station.HasFaults Then
		    DrawFaultIcon(g)
		  elseIf station.MaintenanceActive Then
		    DrawMaintenanceIcon(g)
		  Else
		    DrawPinIcon(g, drawingColor)
		  End
		  
		  Return New WebPicture(p)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawFaultIcon(g as Graphics)
		  Var h As Integer = g.Height 
		  Var w As Integer = g.Width
		  
		  Var fx As New FigureShape
		  fx.AddLine(0, h, w/2, 0)
		  fx.AddLine(w/2, 0, w, h)
		  fx.BorderOpacity = 100 ' opaque border
		  fx.BorderColor = Color.White
		  fx.BorderWidth = 3
		  fx.FillColor = &cFF262500
		  g.DrawObject(fx)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawMaintenanceIcon(g as Graphics)
		  Var h As Integer = g.Height * 0.8
		  Var w As Integer = g.Width * 0.8
		  Var x As Integer = (g.Width - w) / 2
		  Var y As Integer = (g.Height - h) / 2
		  
		  g.DrawingColor = &cFFC10700
		  g.FillRectangle(x, y, w, h)
		  
		  g.DrawingColor = Color.White
		  g.PenSize = 3
		  g.DrawRectangle(x, y, w, h)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawPinIcon(g as Graphics, drawingColor as Color)
		  Var h As Integer = g.Height * 0.9
		  Var w As Integer = g.Width * 0.9
		  Var x As Integer = (g.Width - w) / 2
		  Var y As Integer = (g.Height - h) / 2
		  
		  g.DrawingColor = drawingColor
		  g.FillOval(x, y, w, h)
		  
		  g.DrawingColor = Color.White
		  g.PenSize = 4
		  g.DrawOval(x, y, w, h)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetInfos(extends station as StationModel) As String
		  Return kStationInforHtmlTemplate _
		  .Replace("#UId#", station.Uid) _
		  .Replace("#ShortName#", station.ShortName) _
		  .Replace("#Type#", station.Type) _
		  .Replace("#Location#", str(Station.Latitude) + " / " + str(station.Longitude))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasFaults(extends station as StationModel) As Boolean
		  For Each component As ComponentModel In station.Components
		    If component.TypeDef = Enums.ComponentTypes.Fault And component.CurrentValue.IntegerValue <> 0 Then
		      Return True
		    End
		  Next
		  Return False
		End Function
	#tag EndMethod


	#tag Constant, Name = kStationInforHtmlTemplate, Type = String, Dynamic = False, Default = \"<raw>\n  <div style\x3D\'margin: 0 20px;\'>\n    <div style\x3D\'font-weight: bold;\'>Stationsinfo</div>\n    <div style\x3D\'font-size: 0.8em;\'>\n      <div>UId: #UId#</div>\n      <div>Kurzname: #ShortName#</div>\n      <div>Typ: #Type#</div>\n      <div>L\xC3\xA4nge/Breite: #Location#</div>\n    </div>\n  </div>\n</raw>", Scope = Private
	#tag EndConstant


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
