#tag Class
Protected Class App
Inherits LobBase.LobWebApplication
	#tag Event
		Function HandleUrl(request as WebRequest, response as WebResponse) As Boolean
		  Log.Debug("Request to path=" + request.Path + " with query=" + request.QueryString + " and User-Agent=" + request.Header("User-Agent") + " received.", CurrentMethodName)
		  
		  HandleApiRequests(request, response)
		  
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub Opening(args() as String)
		  // initialize app, logging, etc (Status API-KEY shall not contain $ because this breaks the HTTP-Header value)
		  InitApp("Sentraq-Platform", "Watermann IT, Germany", App.ApiAuthKeyValue)
		  
		  InitAppServices()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Stopping(shuttingDown as Boolean)
		  Log.Info("App stopped.", CurrentMethodName)
		End Sub
	#tag EndEvent

	#tag Event
		Function UnhandledException(error As RuntimeException) As Boolean
		  Try
		    
		    Log.Critical("App crashed: [" + Str(error.ErrorNumber) + "] " + error.Message + " | " + String.FromArray(error.Stack, "; "), CurrentMethodName)
		    
		    Try
		      // try inform all session about connection lost
		      For Each s As WebSession In Self.Sessions
		        s.ExecuteJavaScript("system.log('Hinweis: Die Verbindung zum Daten-Service ist unterbrochen und wird automatisch wiederhergestellt.')")
		      Next
		    Catch
		    End
		    
		  Catch err
		    //Make sure we do not create another exception
		  End Try
		  
		  //Return true to let the app running
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub UpdateCustomStatusRequestApiData(statusRequestApiData as Dictionary)
		  statusRequestApiData.Value("UserSessions") = Self.CurrentUserSessions
		  statusRequestApiData.Value("Backend") = Self.DataSvc.GetBackendStatusInfo.ToJson
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub AddOrUpdateUserSession(secureSessionId as string)
		  If Self.UserSessions <> Nil Then
		    Self.UserSessions.Value(secureSessionId) = DateTime.Now.SQLDateTime
		  end
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DataReloadTimerAction(sender as Object)
		  Log.Debug(CurrentMethodName)
		  
		  // reload stations from controller api
		  Self.DataSvc.LoadStations
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleApiRequests(request as WebRequest, response as WebResponse)
		  Try
		    
		    // handle unauthorized monibot.io requests to monitor service availability
		    // response contains a string that can be checked by monibot.io: ControllerUp=True/False
		    If request.Path = "api/monibot" Then
		      response.Status = HandleMonibotRequest(request, response)
		      Return
		    End
		    
		    // all other requests need to have a valid API-KEY (see App.StatusService.ApiKey config value) set
		    If request.HeaderNames.IndexOf("X-AUTH-KEY") >= 0 And request.Header("X-AUTH-KEY") = ApiAuthKeyValue Then
		      
		      If request.Path.BeginsWith("api/update/realtime/") Then
		        response.Status = HandleUpdateComponentValueRequest(request, response)
		        
		      ElseIf request.Path = "api/reloadstations" Then
		        response.Status = HandleReloadDataRequest(request, response)
		        
		      Else
		        // invalid request
		        response.Status = 400
		        
		      End
		      
		    Else
		      // unauthorized
		      response.Status = 401
		      
		    End
		    
		  Catch e As RuntimeException
		    Log.Error("Error while processing api request to '" + request.Path + "': [" + Str(e.ErrorNumber) + "] " + e.Message + " (" + String.FromArray(e.Stack, "; "), CurrentMethodName)
		    response.Status = 500
		    
		  End
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function HandleMonibotRequest(request as WebRequest, response as WebResponse) As Integer
		  // called by monibot.io to monitor service availability
		  // monibot can be configured to generate an alert if response is not ControllerUp=True
		  // se monibot.io for details abount monibot
		  Var backendStatus As BackendStatusInfo = Self.DataSvc.GetBackendStatusInfo
		  response.Write("ControllerUp=" + backendStatus.ControllerUp.ToString)
		  Return 200
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function HandleReloadDataRequest(requets as WebRequest, response as WebResponse) As integer
		  // reload stations and components from controller api
		  // called frequently to decouple frontend requests from backend logic
		  Self.DataSvc.LoadStations
		  
		  // return http status success
		  Return 200
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function HandleUpdateComponentValueRequest(request as WebRequest, response as WebResponse) As Integer
		  // update realtime data
		  // called by backend Controller when new data has arrived
		  // URL: /api/update/realtime/<component-uid>
		  Try
		    If request.Path.CountFields("/") = 4 Then
		      Var uid As String = request.Path.NthField("/", 4)
		      If uid <> "" Then
		        Var body As String = request.Body
		        
		        Log.Debug("Realtime data received for component " + uid + ", data: " + body, CurrentMethodName)
		        
		        // JSON data key-names has to be in camelCase
		        Var data As New JSONItem(body)
		        Var component As ComponentModel = App.DataSvc.GetComponentByHardwareId(uid)
		        component.CurrentValue = data.Value("value")
		        component.LastReceivedTs = data.value("ts").DateTimeValue
		        
		        // reload station if component type is fault to get info about active alert
		        If component.TypeDef = Enums.ComponentTypes.Fault Then
		          Self.DataSvc.LoadStation(component.StationUid)
		        End
		        
		        Return 200
		      End
		    End
		    Return 400
		  Catch error As RuntimeException
		    Log.Error("[" + Str(error.ErrorNumber) + "] " + error.Message + " | " + String.FromArray(error.Stack, "; "), CurrentMethodName)
		    Return 500
		  End
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub InitAppServices()
		  // Initialize sesison services
		  Self.DataSvc = New DataService
		  Self.DataSvc.LoadStations
		  
		  // start data reload timer
		  Self.DataReloadTimer = New Timer
		  Self.DataReloadTimer.Period = App.ConfigValue("DataReload.PeriodSec", 60).IntegerValue * 1000
		  Self.DataReloadTimer.RunMode = timer.RunModes.Multiple
		  AddHandler Self.DataReloadTimer.Action, AddressOf DataReloadTimerAction
		  Self.DataReloadTimer.Enabled = True
		  
		  // Init UserSessions dictionary
		  Self.UserSessions = New Dictionary
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveUserSession(secureSessionId as string)
		  If Self.UserSessions <> nil and Self.UserSessions.HasKey(secureSessionId) Then
		    Self.UserSessions.Remove(secureSessionId)
		  end
		End Sub
	#tag EndMethod


	#tag Note, Name = Readme
		SentraQ Frontend
		------------------
		
		Open-Source Software by Stefan Watermann
		License: GNU General Public License v3.0
		Copyright (c) 2026 Stefan Watermann, Watermann IT, Auetal (Germany)
		https://github.com/stefanwatermann/SentraQ
		
		IMPORTANT: please search for all <todo> tags and fill in meaningful values!
	#tag EndNote


	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  return self.ConfigValue("App.StatusService.ApiKey")
			End Get
		#tag EndGetter
		Private ApiAuthKeyValue As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return "Powered by SentraQ - (c) " + str(DateTime.Now.Year) + " Watermann IT, Auetal"
			End Get
		#tag EndGetter
		AppCopyrightText As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Var f As FolderItem = App.AppDataFolder.Child(App.ConfigValue("App.Header.Logo", "applogo.png"))
			  
			  If f <> Nil And f.Exists Then
			    Var p As Picture = Picture.Open(f)
			    Return p
			  End
			  
			  Var p As New Picture(40, 40)
			  p.Graphics.DrawingColor = &c91919100
			  p.Graphics.FillRectangle(0, 0, p.Graphics.Width, p.Graphics.Height)
			  Return p
			End Get
		#tag EndGetter
		AppHeaderLogo As Picture
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return App.ConfigValue("App.Header.Title", "SentraQ - Monitoring Platform")
			End Get
		#tag EndGetter
		AppHeaderTitle As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Var s() As String
			  For Each ssid As String In Self.UserSessions.Keys
			    s.Add(ssid + ":" + Self.UserSessions.Value(ssid))
			  Next
			  Return String.FromArray(s, ";")
			End Get
		#tag EndGetter
		Private CurrentUserSessions As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private DataReloadTimer As Timer
	#tag EndProperty

	#tag Property, Flags = &h0
		DataSvc As DataService
	#tag EndProperty

	#tag Property, Flags = &h21
		Private UserSessions As Dictionary
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="AppCompany"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AppVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AppName"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AppProcessGuid"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AppCopyrightText"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AppHeaderLogo"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AppHeaderTitle"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
