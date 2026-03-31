#tag Class
Protected Class WebAuthentication
	#tag Method, Flags = &h0
		Sub ClearCurrentUser()
		  Session.Cookies.Set(CookieName, "", DateTime.Now, Self.Domain, "/", False, False, WebCookieManager.SameSiteStrength.Strict)
		  Session.Cookies.Remove(CookieName, Self.Domain, "/")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(salt as String, authProvider as IAuthenticationStoreProvider, cookieExpiration as DateTime = nil)
		  Self.Salt = salt
		  Self.AuthStoreProvider = authProvider
		  Self.CookieExpires = cookieExpiration
		  
		  If cookieExpiration = Nil Then
		    // Default expiration = 1 day
		    Self.CookieExpires = DateTime.Now.AddInterval(0, 0, 1)
		  End
		  
		  If Self.AuthStoreProvider = Nil Or Not Self.AuthStoreProvider IsA IAuthenticationStoreProvider Then
		    Raise New RuntimeException("AuthenticationProvider must be set to an instance of a class implementing the IAuthenticationStoreProvider interface.")
		  End
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateUserHash(username as string, pwd as string) As string
		  // Create hash for username and password.
		  Var code As String = Crypto.BlowFishEncrypt(pwd + salt, username + salt + pwd)
		  Var hash As String = EncodeHex(Crypto.SHA3_512(code))
		  Return hash
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetCurrentUser(user as String, pwd as String)
		  // save sessionHash in Browser cookie
		  Var hash As String = CreateUserHash(user, pwd)
		  Session.Cookies.Set(Self.CookieName, hash, Self.CookieExpires, Self.Domain, "/", False, False, WebCookieManager.SameSiteStrength.Strict)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private AuthStoreProvider As IAuthenticationStoreProvider
	#tag EndProperty

	#tag Property, Flags = &h21
		Private CookieExpires As DateTime
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  return EncodeHex(MD5(Session.FQDN + "#AuthCookie#" + Self.Salt))
			End Get
		#tag EndGetter
		Private CookieName As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  // read sessionHash from Browser cookie
			  Return Session.Cookies.Value(Self.CookieName)
			End Get
		#tag EndGetter
		Private CurrentSessionHash As string
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Self.AuthStoreProvider.HasKey(Self.CurrentSessionHash) Then
			    Return Self.AuthStoreProvider.GetValue(Self.CurrentSessionHash).NthField(":", 1)
			  End
			End Get
		#tag EndGetter
		CurrentUserName As string
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Self.AuthStoreProvider.HasKey(Self.CurrentSessionHash) Then
			    Return Self.AuthStoreProvider.GetValue(Self.CurrentSessionHash).NthField(":", 2)
			  End
			End Get
		#tag EndGetter
		CurrentUserRole As string
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  If Session.FQDN.Contains(":") Then
			    Return "." // localhost hack(??)
			  Else
			    Return Session.FQDN
			  End
			End Get
		#tag EndGetter
		Private Domain As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.AuthStoreProvider.HasKey(Self.CurrentSessionHash)
			  
			End Get
		#tag EndGetter
		IsAuthenticatedUser As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private Salt As String
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
			Name="IsAuthenticatedUser"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CurrentUserName"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="CurrentUserRole"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
