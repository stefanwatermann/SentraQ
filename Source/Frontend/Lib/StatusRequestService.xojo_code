#tag Class
 Attributes ( "@Guid" = "F14B832F-B9DB-423D-AE87-C4AFBC71DCD6", "@Copyright" = "(c) 2023 watermann IT, Stefan Watermann, Germany", "@Author" = "Stefan Watermann", "@Description" = "Creates standard status info and handles a WebRequest.", "@Version" = "1.0.3" ) Protected Class StatusRequestService
	#tag Method, Flags = &h0
		Sub Constructor(applicationVersion as string, urlPath as string = "status", apiKey as string = "")
		  Self.StartedAt = DateTime.Now
		  Self.AppVersion = applicationVersion
		  Self.Path = urlPath
		  Self.ApiKey = apiKey
		  Self.CustomStatusApiData = new Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetSystemUptime() As string
		  Try
		    Var sh As New shell
		    sh.Execute("uptime")
		    Return sh.Result.Trim
		  Catch e As RuntimeException
		    Return "error reading system uptime. " + e.Message
		  End
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HandleStatusRequest(request as WebRequest, response as WebResponse) As Boolean
		  If IsStatusApiRequest(request) Then
		    
		    If request.HeaderNames.IndexOf("X-API-KEY") >= 0 Or Self.ApiKey = "" Then
		      Var apiKey As String = request.Header("X-API-KEY")
		      
		      If apiKey = Self.ApiKey Or Self.ApiKey = "" Then
		        Var data As New JSONItem
		        data.Value("AppVersion") = AppVersion
		        data.Value("AppUptime") = UpTimeText
		        data.Value("AppUptimeMinutes") = UpTimeMinutes
		        data.value("AppStartTs") = StartedAt.SQLDateTime
		        data.Value("ServerTime") = Datetime.Now.SQLDateTime
		        data.Value("SystemUptime") = GetSystemUptime
		        
		        If CustomStatusApiData <> Nil Then
		          For Each key As String In CustomStatusApiData.Keys
		            data.Value(key) = CustomStatusApiData.Value(key)
		          Next
		        End
		        
		        response.MIMEType = "text/json"
		        response.Write(data.ToString)
		        response.Status = 200
		        
		        Return True
		      End
		      
		    End
		    
		  Else
		    Return False
		  End
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsStatusApiRequest(request as WebRequest) As Boolean
		  return request.Method = "GET" And request.Path = Path
		End Function
	#tag EndMethod


	#tag Note, Name = History
		v1.0.4 - 2026-02-06
		---------------------
		- UpperCase first letter in StatusApi
		
		v1.0.1 - 2024-06-14
		-------------------
		- new element in json: tag, used for custom data
		
	#tag EndNote

	#tag Note, Name = Readme
		Handles a WebRequest to a status url and returns a JSON response.
		
		Example JSON response:
		
		{
		  "appVersion": "1.0.0.10",
		  "appUptime": "1 days, 2 hours, 1 minutes",
		  "appUptimeMinutes": 1561,
		  "appStartTs": "2023-12-09 10:31:27",
		  "serverTime": "2023-12-10 12:33:04",
		  "systemUptime": "12:33  up 8 days, 23:50, 2 users, load averages: 1.17 1.54 1.54\n"
		}
		
		
		-----
		
		Usage:
		
		1) Add (private) property to App object:
		
		    Private Property StatusRequestSvc As StatusRequestService
		
		
		2) Create instance of StatusRequestService in Opening() event 
		   with version string of App and Url-Path to listen to GET requests:
		
		    App.StatusRequestSvc = new StatusRequestService(App.AppVersion, "status")
		
		
		3) Call HandleStatusRequest(...) from HandleUrl() event: 
		
		    Return StatusRequestSvc.HandleStatusRequest(request, response)
		
		
	#tag EndNote


	#tag Property, Flags = &h21
		Private ApiKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private AppVersion As String
	#tag EndProperty

	#tag Property, Flags = &h0
		CustomStatusApiData As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Path As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private StartedAt As DateTime
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  return DateTime.now - StartedAt
			End Get
		#tag EndGetter
		Private UpTime As Dateinterval
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Return UpTime.Days * 1440 + _
			  UpTime.Hours * 60 + _
			  UpTime.Minutes
			End Get
		#tag EndGetter
		Private UpTimeMinutes As Int64
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  If Uptime.Days > 0 Then
			    Return str(UpTime.Days) + " days, " + Str(UpTime.Hours) + " hours, " + Str(UpTime.Minutes) + " minutes"
			  ElseIf uptime.Hours > 0 Then
			    Return Str(uptime.Hours) + " hours, " + Str(UpTime.Minutes) + " minutes"
			  Else
			    Return Str(uptime.Minutes) + " minutes"
			  End
			End Get
		#tag EndGetter
		Private UpTimeText As string
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
