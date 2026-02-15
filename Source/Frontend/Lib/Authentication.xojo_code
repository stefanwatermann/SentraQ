#tag Module
 Attributes ( "@Guid" = "A20F6DCD-A5C1-400D-825A-7F960DA22D89", "@Version" = "1.2.0", "@Copyright" = "(c) 2023 Stefan Watermann, Germany", "@Author" = "Stefan Watermann", "@Description" = "Authenticaton for WebApplication projects. Authentication information can be loaded from file, Sqlite or MySql database.", "@Depends" = "File, WebSessionExtensions" ) Protected Module Authentication
	#tag Note, Name = History
		v1.2.0 - 2025-12-08
		--------------------
		- Introduction of IAuthenticationStoreProvider interface to allow different ways of readign authentication data
		- Implementation of file based and Sqlite based store provider
		- value of cookie is now blowfish encrypted data (see CreateUserHash)
		- defaul session periode is now 1 day
		
		v1.1.0 - 2025-06-26
		-------------------
		- Redesign, SHA3_512 Hash 
		
		v1.0.1 - 2023-10-02
		-------------------
		- New property "CurrentUser"
		
	#tag EndNote

	#tag Note, Name = Readme
		Einbindung in App/Sesison Klasse
		----------------------------------
		
		Property:
		Public Property Authenticator As Authentication.WebAuthentication
		
		In Opening Event:
		
		---code---
		Using Authentication
		
		// file based Authentication store
		//Var authProvider As IAuthenticationStoreProvider = New AuthenticationFileStoreProvider
		//authProvider.Init(App.AppDataFolder.Child("users.list"))
		
		// Sqlite database based Authentication store
		Var authProvider As IAuthenticationStoreProvider = New AuthenticationSqliteStoreProvider
		authProvider.Init(App.AppDataFolder.Child("users.db"))
		
		// Init Authenticator, with 5 days of cookie time 
		// HINT: kAuthenticationSalt should not be part of teh code, better load from config
		Self.Authenticator = New WebAuthentication(kAuthenticationSalt, authProvider, DateTime.Now.AddInterval(0, 0, 5))
		
		// example to create a valid hashcode from username and password
		//Var h As String = Self.Authenticator.CreateUserHash("test", "test")
		//Break
		---code---
		
		
		Verwendung im Code
		----------------------
		
		Im Logon Dialog nach Klick auf "Logon":
		- SetCurrentUser(userName, Password)
		
		Bei Logoff:
		- ClearCurrentUser()
		
		CurrentUserName -> Name aus der User Datei / Datenbank
		
		CurrentUserRole -> Role aus der User Datei / Datenbank
		
		IsAuthenticatedUser liefert True wenn der User angemeldet ist, unabhängig von der Rolle.
		
	#tag EndNote


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
