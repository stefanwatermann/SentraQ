#tag Class
Protected Class AuthenticationWebApiStoreProvider
Implements Authentication.IAuthenticationStoreProvider
	#tag Method, Flags = &h0
		Function GetValue(key as String) As String
		  // Part of the Authentication.IAuthenticationStoreProvider interface.
		  For Each user As UserModel In Self.KnownUsers
		    If user.Hash = key Then
		      Return user.Login + ":" + user.Role
		    End
		  Next
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasKey(key as string) As Boolean
		  // Part of the Authentication.IAuthenticationStoreProvider interface.
		  For Each user As UserModel In Self.KnownUsers
		    If user.Hash = key Then
		      Return True
		    End
		  Next
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Init(param as Variant)
		  // Part of the Authentication.IAuthenticationStoreProvider interface.
		  Self.KnownUsers = App.DataSvc.GetUsers()
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		KnownUsers() As UserModel
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
	#tag EndViewBehavior
End Class
#tag EndClass
