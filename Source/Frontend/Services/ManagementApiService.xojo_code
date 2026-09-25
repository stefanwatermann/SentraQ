#tag Class
Protected Class ManagementApiService
	#tag Method, Flags = &h21
		Private Function Authorized() As Boolean
		  // authorization for the management api, based on the provided ApiAuthHeader (SharedProp) value.
		  
		  // get configiured mgmt key value
		  Var requiredMgmtValue As String = app.ConfigValue("App.ManagementService.ApiKey").StringValue.Trim
		  If requiredMgmtValue = "" Then
		    Raise New RuntimeException("App.ManagementService.ApiKey not set in app-config.")
		  End
		  
		  // read provided mgmt http-header value
		  Var username As String = CurrentRequest.Header("X-LOGIN").Trim
		  
		  // read provided mgmt http-header value
		  Var sentMgmtValue As String = CurrentRequest.Header("X-MGMT-KEY").Trim
		  
		  // read provided user auth-key 
		  Var sentUserAuthValue As String = CurrentRequest.Header("X-AUTH-KEY").Trim
		  
		  return sentMgmtValue = requiredMgmtValue and IsAuthenticatedUser(username, requiredMgmtValue, sentUserAuthValue)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function IsAuthenticatedUser(username as string, mgmtKey as string, authKey as string) As Boolean
		  // validate value of encrypted authkey sent by the management client
		  
		  Var t As String = Str(DateTime.Now.DayOfYear)
		  Var k As String = username + t + mgmtKey.Right(56 - username.Length - t.Length)
		  Var d As String = DecodeBase64(authkey)
		  Var s As String = DecodeHex(Crypto.BlowFishDecrypt(k, d))
		  
		  Var authProvider As Authentication.IAuthenticationStoreProvider = New AuthenticationWebApiStoreProvider
		  authProvider.Init(Nil)
		  
		  var salt as string = App.ConfigValue("Session.AuthenticationSalt")
		  var aw as new Authentication.WebAuthentication(salt, authProvider, nil)
		  Var hash As String =  aw.CreateUserHash(s.NthField(":", 1), s.NthField(":", 2))
		  
		  Var isAuthenticated As Boolean
		  For Each user As UserModel In App.DataSvc.GetUsers
		    If user.Login = username And user.Hash = hash And user.Role = "ADM" Then
		      isAuthenticated = True
		      exit For
		    end
		  Next
		  
		  return isAuthenticated
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ProcessApiRequest(request as WebRequest, response as WebResponse) As Integer
		  Log.Info(request.Method + " call to management-api path=" + request.Path, CurrentMethodName)
		  
		  Self.CurrentRequest = request
		  Self.CurrentResponse = response
		  return RouteRequest
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ProcessComponent() As Integer
		  Var apiClient As New BackendApiControllerClient
		  
		  If HttpMethod = "GET" Then
		    // get components of station (of param second)
		    CurrentResponse.Write(apiClient.Get("components/station/" + Second))
		    CurrentResponse.MIMEType = "application/json"
		    Return 200
		  End
		  
		  If HttpMethod = "POST" Then
		    // save component
		    Var component As New ComponentModel
		    ComponentModel.FromJson(CurrentRequest.Body, component)
		    CurrentResponse.Write(apiClient.Post("components", component.ToJson, CurrentRequest.Header("X-LOGIN")))
		    Return 200
		  End
		  
		  If HttpMethod = "DELETE" Then
		    // delete component of station (of param first)
		    CurrentResponse.Write(apiClient.Delete("components/" + First, CurrentRequest.Header("X-LOGIN")))
		    Return 200
		  End
		  
		  // request not supported
		  Return 400
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ProcessStation() As Integer
		  Var apiClient As New BackendApiControllerClient
		  
		  if HttpMethod = "GET" then
		    // return list of stations
		    CurrentResponse.Write(apiClient.Get("station/all"))
		    CurrentResponse.MIMEType = "application/json"
		    Return 200
		  End
		  
		  If HttpMethod = "POST" Then
		    // save station
		    Var station As New StationModel
		    StationModel.FromJson(CurrentRequest.Body, station)
		    CurrentResponse.Write(apiClient.Post("station", station.ToJson, CurrentRequest.Header("X-LOGIN")))
		    return 200
		  end
		  
		  If HttpMethod = "DELETE" Then
		    // delete station of station (of param first)
		    CurrentResponse.Write(apiClient.Delete("station/" + First, CurrentRequest.Header("X-LOGIN")))
		    Return 200
		  End
		  
		  // request not supported
		  return 400
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ProcessStatus() As Integer
		  Var status As BackendStatusInfo = App.DataSvc.GetBackendStatusInfo
		  CurrentResponse.Write(status.ToJsonString)
		  CurrentResponse.MIMEType = "application/json"
		  Return 200
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RouteRequest() As Integer
		  If Not Authorized Then
		    // access to the recource is not allowd
		    Log.Warning("Unauthorized " + self.CurrentRequest.Method + " call to management-api, path=" + Self.CurrentRequest.Path, CurrentMethodName)
		    Return 403
		  End
		  
		  // route request to a corresponding request-handler
		  Select Case Area
		    
		  Case "station"
		    Return ProcessStation
		    
		  Case "component"
		    Return ProcessComponent
		    
		  Case "status"
		    Return ProcessStatus
		    
		  End
		  
		  // no handler found, invalid request
		  Log.Warning(Self.CurrentRequest.Method + " call to not existing management-api path=" + Self.CurrentRequest.Path, CurrentMethodName)
		  return 404
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return "api/" + ApiUrlKey + "/manage/"
			End Get
		#tag EndGetter
		Shared ApiBasePath As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  var a as string = app.ConfigValue("App.ManagementService.ApiKey").StringValue.Trim
			  return a.Left(a.Length / 2)
			End Get
		#tag EndGetter
		Private Shared ApiUrlKey As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  // first element after base-path is called "area", e.g. station or component
			  return CurrentRequest.Path.NthField("/", ApiBasePath.CountFields("/")).Lowercase.Trim
			End Get
		#tag EndGetter
		Private Area As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private CurrentRequest As WebRequest
	#tag EndProperty

	#tag Property, Flags = &h21
		Private CurrentResponse As WebResponse
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  // first element after "area", e.g. stationUid
			  If CurrentRequest.Path.CountFields("/") <= ApiBasePath.CountFields("/") Then
			    return ""
			  End
			  
			  Return CurrentRequest.Path.NthField("/", ApiBasePath.CountFields("/") + 1)
			End Get
		#tag EndGetter
		Private First As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Return CurrentRequest.Method
			End Get
		#tag EndGetter
		Private HttpMethod As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  // first element after "area", e.g. stationUid
			  If CurrentRequest.Path.CountFields("/") <= ApiBasePath.CountFields("/") + 1 Then
			    return ""
			  End
			  
			  Return CurrentRequest.Path.NthField("/", ApiBasePath.CountFields("/") + 2)
			End Get
		#tag EndGetter
		Private Second As String
	#tag EndComputedProperty


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
