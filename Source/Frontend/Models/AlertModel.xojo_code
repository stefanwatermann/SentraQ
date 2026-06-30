#tag Class
Protected Class AlertModel
Inherits JsonModelBase
	#tag Method, Flags = &h0
		Shared Function CreateCsvString(data() as AlertModel, fieldSeparator as string = ";") As string
		  Var header As String = "Stationsname,Stations-ID,Störungen,Beginn,Ende,Quittiert um,Quittiert von"
		  
		  Var s() As String
		  s.Add(header.ReplaceAll(",", fieldSeparator))
		  
		  For Each a As AlertModel In data
		    Var l() As String
		    l.Add(a.StationShortName)
		    l.Add(a.StationUid)
		    l.Add(a.Faults)
		    l.Add(a.FirstEventTs.ToString("yyyy-MM-dd HH:mm"))
		    l.Add(a.LastEventTs.ToString("yyyy-MM-dd HH:mm"))
		    l.Add(if(a.ConfirmedAt = nil, "", a.ConfirmedAt.ToString("yyyy-MM-dd HH:mm")))
		    l.Add(a.ConfirmedBy)
		    s.Add(string.FromArray(l, fieldSeparator))
		  Next
		  
		  return string.FromArray(s, EndOfLine)
		End Function
	#tag EndMethod


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
		StationShortName As String
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
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ConfirmedBy"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Faults"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsActive"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
