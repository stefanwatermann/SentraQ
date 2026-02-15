#tag Class
Protected Class Session
Inherits WebSession
#tag Session
  interruptmessage=Die Verbindung zum Server wird neu aufgebaut. Dr\xC3\xBCcken Sie F5\x2C falls die Verbindung nicht automatisch wiederhergestellt wird.
  disconnectmessage=Die Verbindung zum Server ist abgebrochen\x2C Sie wurden von der Anwendung getrennt. Bitte pr\xC3\xBCfen Sie Ihre Internetverbindung.
  confirmmessage=
  AllowTabOrderWrap=True
  ColorMode=1
  SendEventsInBatches=False
#tag EndSession
	#tag Event
		Function AllowUnsupportedBrowser(ByRef errorMessage As String, ByRef sendAsHTML As Boolean) As Boolean
		  // do not allow unsupported browsers
		  Return False
		End Function
	#tag EndEvent

	#tag Event
		Sub HashtagChanged(name As String, data As String)
		  Log.Info("HashTag changed to '" + name + "'", Self.SecureSessionId)
		  
		  NavigateTo(name)
		End Sub
	#tag EndEvent

	#tag Event
		Sub JavaScriptError(errorName as String, errorMessage as String, errorStack as String)
		  Log.Error(Self.GetJavaScriptError(ErrorName, ErrorMessage, ErrorStack), Self.SecureSessionId)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  // start secure session 
		  StartSession()
		  
		  // open requested page or default page
		  NavigateTo(Self.HashTag)
		End Sub
	#tag EndEvent

	#tag Event
		Sub PreparingSession(ByRef HTMLHeader As String)
		  Log.Debug(CurrentMethodName, Session.SecureSessionId)
		  
		  ResetExecutionTime
		End Sub
	#tag EndEvent

	#tag Event
		Function UnhandledException(error As RuntimeException) As Boolean
		  return ShowUnhandledSessionError(error)
		End Function
	#tag EndEvent

	#tag Event
		Sub UserDisconnected()
		  Log.Info("User disconnected. User: " + Self.Authenticator.CurrentUserName + ", Remote-Address: " + Self.RemoteAddress, Self.SecureSessionId)
		  
		  // remove userSession
		  App.RemoveUserSession(Self.SecureSessionId)
		End Sub
	#tag EndEvent

	#tag Event
		Sub UserTimedOut()
		  Log.Info("User timed-out. User: " + Self.Authenticator.CurrentUserName + ", Remote-Address: " + Self.RemoteAddress, Self.SecureSessionId)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function DecodeStationFromHashtag(name as string) As string
		  Var ht As String = DecodeURLComponent(name)
		  
		  // hashtag containig station-uid?
		  If ht.Contains(",") Then
		    Self.CurrentSelectedStationUid = ht.NthField(",", 2).Trim
		    ht = ht.NthField(",", 1).Trim
		  Else
		    Self.CurrentSelectedStationUid = ""
		  End
		  
		  return ht
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSessionExecutionTime() As String
		  Var ts As DateInterval = DateTime.Now - Self.SessionStartDt
		  return str(ts.Seconds) + "." + str(ts.Nanoseconds).left(2) + "sec"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub InitAuthentiation()
		  Var authProvider As Authentication.IAuthenticationStoreProvider = New AuthenticationWebApiStoreProvider
		  authProvider.Init(Nil)
		  
		  // Init Authenticator, with 5 days of cookie time
		  Self.Authenticator = New Authentication.WebAuthentication(AuthenticationSalt, authProvider, DateTime.Now.AddInterval(0, 0, App.ConfigValue("Auth.CookieDurationDays", 1).IntegerValue))
		  
		  // example to create valid hashcodes for a list of usernames
		  //Var users As String = "admin,user,tester,<todo>"
		  //For Each user As String In users.Split(",")
		  //Var pwd As String = "<todo>" + CodeGen.GenerateCode(4, True)
		  //Var h1 As String = Self.Authenticator.CreateUserHash(user, pwd)
		  //System.DebugLog(user + ":USR:" + h1)
		  //System.DebugLog("Benutzername: " + user + " Passwort: " + pwd)
		  //Next
		  //Break
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub InitPageHandler()
		  // Init WebPage handler
		  // Call Session.PageHandler.RegisterPage(...) for each page to allow navigation by hashtag
		  Self.PageHandler = New LobBase.LobWebPageHandler(PageLogon, PageNoAccess, PageNotFound)
		  Self.PageHandler.RegisterPage(PageStationView, "station")
		  Self.PageHandler.RegisterPage(PageMapView, "map")
		  Self.PageHandler.RegisterPage(PageRestricted, "restricted")
		  Self.PageHandler.RegisterPage(PageLogon, "logon")
		  Self.PageHandler.RegisterPage(PageLowRes, "lowres")
		  Self.PageHandler.RegisterPage(PageHtmlContent, "privacy")
		  Self.PageHandler.RegisterPage(PageHtmlContent, "imprint")
		  Self.PageHandler.RegisterPage(PageNotFound, "404")
		  Self.PageHandler.RegisterPage(PageNoAccess, "403")
		  Self.PageHandler.RegisterPage(PagePasswordReset, "pset")
		  
		  If Self.Authenticator.CurrentUserRole = "ADM" Then
		    Self.PageHandler.RegisterPage(PageAdmin, "admin")
		  End
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub InitServices()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Logoff()
		  Log.Info("Logoff executed. User: " + Session.Authenticator.CurrentUserName, Self.SecureSessionId)
		  
		  // Remove User Cookie
		  Self.Authenticator.ClearCurrentUser
		  
		  Self.GoToURL("/")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub NavigateTo(hashtag as string)
		  Var ht As String = DecodeStationFromHashtag(hashtag)
		  
		  If ht = "" And Session.Authenticator.IsAuthenticatedUser Then
		    ht = "station"
		  end
		  
		  // open requested page or default page
		  If Self.ClientWidth < kMinClientWidth Then
		    // if client-width is too smal (e.g. mobile-phone) show hint instead of selected page
		    Self.CurrentPage = PageLowRes
		    
		  ElseIf hashtag = "logoff" Then
		    Self.Logoff
		    
		  Else
		    // navigate to selected page (by hashtag)
		    Self.PageHandler.ShowPage(ht)
		    
		  End
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResetExecutionTime()
		  Self.SessionStartDt = DateTime.Now
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub StartSession()
		  // Entrance into the user-session and initialisation of servcies
		  MyProfiler.Start(CurrentMethodName)
		  
		  ResetExecutionTime
		  
		  // Init and start persistent browser session using cookie
		  Self.SecureSession = New SecureBrowserSession(Self, App.ConfigValue("Session.CookieDurationDays", 30))
		  Self.SecureSession.RequestSessionDataSync
		  
		  Log.Info("Starting session. Sub-Domain: " + Self.SubDomain + ", Remote-Address: " + Self.RemoteAddress + ", User-Agent: " + Self.UserAgent + ", ClientWidth: " + Str(Self.ClientWidth), Self.SecureSessionId)
		  
		  // set language (zunächst nur deutsch unterstüzt)
		  Self.LanguageCode = "de-DE"
		  
		  // Init Authentication 
		  InitAuthentiation()
		  
		  // init all services
		  InitServices
		  
		  // Init Web-Pages Handler
		  InitPageHandler()
		  
		  // save userSession
		  App.AddOrUpdateUserSession(self.SecureSessionId)
		  
		  MyProfiler.Stop(CurrentMethodName)
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  return App.ConfigValue("Session.AuthenticationSalt")
			End Get
		#tag EndGetter
		Private AuthenticationSalt As String
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Authenticator As Authentication.WebAuthentication
	#tag EndProperty

	#tag Property, Flags = &h0
		CurrentAction As String
	#tag EndProperty

	#tag Property, Flags = &h0
		CurrentSelectedStationUid As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return App.DataSvc.GetUserByLogin(self.Authenticator.CurrentUserName)
			End Get
		#tag EndGetter
		CurrentUser As UserModel
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private PageHandler As LobBase.LobWebPageHandler
	#tag EndProperty

	#tag Property, Flags = &h21
		Private SecureSession As SecureBrowserSession
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Self.SecureSession = Nil Then
			    Return "session-id unknown"
			  End
			  
			  return self.SecureSession.SessionId
			End Get
		#tag EndGetter
		SecureSessionId As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private SessionStartDt As DateTime
	#tag EndProperty


	#tag Constant, Name = kMinClientWidth, Type = Double, Dynamic = False, Default = \"320", Scope = Private, Description = 4D696E696D756D2073697A65206F66207468652065787065637465642062726F777365722077696E646F772E
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
			Name="Hashtag"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Identifier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LanguageCode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LanguageRightToLeft"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RemoteAddress"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ScaleFactor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="UserTimeout"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="URL"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_baseurl"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DisconnectMessage"
			Visible=true
			Group="Behavior"
			InitialValue="You have been disconnected from this application."
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InterruptionMessage"
			Visible=true
			Group="Behavior"
			InitialValue="We are having trouble communicating with the server. Please wait a moment while we attempt to reconnect."
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_LastMessageTime"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowTabOrderWrap"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ConfirmDisconnectMessage"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Platform"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsDarkMode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ClientHeight"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ClientWidth"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColorMode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="WebSession.ColorModes"
			EditorType="Enum"
			#tag EnumValues
				"0 - Auto"
				"1 - Light"
				"2 - Dark"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="UserPrefersDarkMode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SendEventsInBatches"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CurrentAction"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SecureSessionId"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="CurrentSelectedStationUid"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
