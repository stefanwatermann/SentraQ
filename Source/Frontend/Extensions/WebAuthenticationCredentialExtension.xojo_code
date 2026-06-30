#tag Module
Protected Module WebAuthenticationCredentialExtension
	#tag Method, Flags = &h0
		Function ToString(extends w as WebAuthenticationCredential) As string
		  return w.ID + "~" + Str(w.AuthenticationAttempts) + "~" + w.DisplayName + "~" + w.PublicKey
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToWebAuthenticationCredential(extends s as string) As WebAuthenticationCredential
		  Var w As New WebAuthenticationCredential
		  w.ID = s.NthField("~", 1)
		  w.AuthenticationAttempts = Val(s.NthField("~", 2))
		  w.DisplayName = s.NthField("~", 3)
		  w.PublicKey = s.NthField("~", 4)
		  return w
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
