#tag Class
Protected Class AuthenticationFileStoreProvider
Implements Authentication.IAuthenticationStoreProvider
	#tag Method, Flags = &h0
		Function GetValue(key as String) As String
		  // Part of the Authentication.IAuthenticationStoreProvider interface.
		  If Self.KnownUsers.KeyCount > 0 And Self.KnownUsers.HasKey(key) Then
		    Return Self.KnownUsers.Value(key).StringValue
		  End
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasKey(key as string) As Boolean
		  // Part of the Authentication.IAuthenticationStoreProvider interface.
		  Return Self.KnownUsers.KeyCount > 0 And Self.KnownUsers.HasKey(key)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Init(param as Variant)
		  // Part of the Authentication.IAuthenticationStoreProvider interface.
		  
		  // param = FolderItem of user-file
		  
		  // expecetd file structure:
		  // username : roles : hash
		  
		  If Not param IsA FolderItem Then
		    Raise New RuntimeException("param is not a FolderItem.")
		  End
		  
		  Var userFile As FolderItem = param
		  
		  System.Log(System.LogLevelInformation, "INFO: reading users from '" + userFile.NativePath + "'.")
		  
		  Self.KnownUsers = New Dictionary
		  
		  Try
		    
		    If userFile <> Nil And userFile.Exists And Not userFile.IsFolder Then
		      
		      Var lines() As String = File.ReadAllLines(userFile)
		      
		      For Each line As String In lines
		        If Not line.BeginsWith("#") And line.CountFields(":") = 3 Then
		          Var user As String = line.NthField(":", 1)
		          Var role As String = line.NthField(":", 2)
		          Var hash As String = line.NthField(":", 3)
		          Self.KnownUsers.Value(hash) = user + ":" + role
		        End
		      Next
		      
		      If Self.KnownUsers.KeyCount = 0 Then
		        System.Log(System.LogLevelError, "ERROR: No user found in '" + userFile.NativePath + "' file, no user will be able to logon to this app!")
		      Else
		        System.Log(System.LogLevelInformation, "INFO: '" + userFile.NativePath + "' loaded containing " + Str(Self.KnownUsers.KeyCount) + " user(s).")
		      End
		      
		    Else
		      System.Log(System.LogLevelError, "ERROR: user file not found, no user will be able to logon to this app!")
		    End
		    
		  Catch e As RuntimeException
		    Var t As Introspection.TypeInfo = Introspection.GetType(e)
		    Var msg As String = "(" + t.FullName + ") " + e.Message
		    System.Log(System.LogLevelCritical, "CRITICAL: cannot read user file: [" + Str(e.ErrorNumber) + "] " + msg)
		    
		  End
		End Sub
	#tag EndMethod


	#tag Note, Name = Readme
		User sind als String-Zeilen im Format "username:roles:hash" in der User Datei abgelegt.
		Role ist ein beliebeiger String, idealerweise 3 Zeichen lang
	#tag EndNote


	#tag Property, Flags = &h21
		Private KnownUsers As Dictionary
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
