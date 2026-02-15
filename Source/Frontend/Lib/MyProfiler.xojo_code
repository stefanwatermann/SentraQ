#tag Module
Protected Module MyProfiler
	#tag Method, Flags = &h0
		Sub Start(tag as string)
		  If Tags = Nil Then
		    Tags = New Dictionary
		  End
		  
		  tags.Value(tag) = DateTime.Now
		  
		  Log.Debug(kProfileStartLogTemplate.Replace("%TAG", tag).Replace("%STARTDT", tags.Value(tag)), CurrentMethodName)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Stop(tag as string)
		  If tags.HasKey(tag) Then
		    Var startDt As DateTime = tags.Value(tag).DateTimeValue
		    Var d As DateInterval = DateTime.now - startDt
		    Var msg As String = Str(d.Minutes) + "." + Str(d.Seconds, "00") + "." + Str(d.Nanoseconds/1000000)
		    Log.Info(kProfileStopLogTemplate.Replace("%TAG", tag).Replace("%DURATION", msg), CurrentMethodName)
		    tags.Remove(tag)
		  End 
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Tags As Dictionary
	#tag EndProperty


	#tag Constant, Name = kProfileStartLogTemplate, Type = String, Dynamic = False, Default = \"PERF: [%TAG] start %STARTDT", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kProfileStopLogTemplate, Type = String, Dynamic = False, Default = \"PERF: [%TAG] duration %DURATION [min.sec.msec]", Scope = Private
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
