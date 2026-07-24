#tag Class
Protected Class EventDataExportModel
Inherits JsonModelBase
	#tag Method, Flags = &h0
		Shared Function CreateCsvString(data() as EventDataExportModel, fieldSeparator as string = ";") As string
		  Var header As String = "Stationsname,Stations-ID,Komponentenname,Komponenten-ID,Komponenten-Typ,Zeitpunkt,Einheit,Wert"
		  
		  Var s() As String
		  s.Add(header.ReplaceAll(",", fieldSeparator))
		  
		  For Each ed As EventDataExportModel In data
		    Var l() As String
		    l.Add(ed.StationName)
		    l.Add(ed.StationUid)
		    l.Add(ed.ComponentName)
		    l.Add(ed.HardwareId)
		    l.Add(ed.ComponentType)
		    l.Add(ed.Received.ToString("yyyy-MM-dd HH:mm"))
		    l.Add(ed.Unit)
		    l.Add(str(ed.Value))
		    s.Add(string.FromArray(l, fieldSeparator))
		  Next
		  
		  return string.FromArray(s, EndOfLine)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		ComponentName As String
	#tag EndProperty

	#tag Property, Flags = &h0
		ComponentType As String
	#tag EndProperty

	#tag Property, Flags = &h0
		HardwareId As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Received As DateTime
	#tag EndProperty

	#tag Property, Flags = &h0
		StationName As String
	#tag EndProperty

	#tag Property, Flags = &h0
		StationUid As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Unit As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Value As Double
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
			Name="StationName"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ComponentName"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ComponentType"
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
			Name="StationUid"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Unit"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Value"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
