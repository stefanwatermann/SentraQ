#tag Class
Protected Class DataService
	#tag Method, Flags = &h0
		Sub ClearAlert(stationUid as string, user as string)
		  Var apiClient As New BackendApiControllerClient
		  Var data As New JSONItem
		  data.Value("user") = user
		  var response as string = apiClient.Post("stations/" + stationUid + "/clearAlert", data)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetBackendStatusInfo() As BackendStatusInfo
		  Var apiClient As New BackendApiControllerClient
		  Var response As String = apiClient.Get("status")
		  Var statusInfo As New BackendStatusInfo
		  UserModel.FromJson(response, statusInfo)
		  Return statusInfo
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetComponentByHardwareId(hardwareId as string) As ComponentModel
		  For Each station As StationModel In Self.Stations
		    For Each component As ComponentModel In station.Components
		      If component.HardwareId = hardwareId Then
		        Return component
		      End
		    Next
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEventData() As EventDataModel()
		  Var apiClient As New BackendApiControllerClient
		  Var response As String = apiClient.Get("eventData")
		  Return PopulateEventData(response)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEventData(filter as string) As EventDataModel()
		  Var apiClient As New BackendApiControllerClient
		  Var response As String = apiClient.Get("eventData/" + filter)
		  Return PopulateEventData(response)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetStationByUid(uid as string) As StationModel
		  For each station As StationModel In Self.Stations
		    If station.Uid = uid Then
		      Return station
		    End
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetUserByLogin(login as string) As UserModel
		  For Each user As UserModel In Self.Users
		    If user.Login = login Then
		      Return user
		    End
		  Next
		  return nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetUserByPasswordResetCode(resetCode as string) As UserModel
		  Var apiClient As New BackendApiControllerClient
		  Var response As String = apiClient.Get("user/byResetCode/" + resetCode)
		  Var user As New UserModel
		  UserModel.FromJson(response, user)
		  Return user
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetUsers() As UserModel()
		  // User Objekte werden gecached und nur beim ersten Aufruf vom Backend geladen.
		  If Self.Users.Count = 0 Then
		    ReadUsers()
		  End
		  
		  Return Self.Users
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadStation(stationUid as string)
		  Var apiClient As New BackendApiControllerClient
		  Var response As String = apiClient.Get("stations/" + stationUid)
		  If response.Length > 0 Then
		    Var s As StationModel = GetStationByUid(stationUid)
		    StationModel.FromJson(response, s)
		  End
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadStations()
		  ReadStations
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function PopulateEventData(response as string) As EventDataModel()
		  Var evDicts() As Variant = ParseJSON(response)
		  Var events() As EventDataModel
		  For Each ev As Dictionary In evDicts
		    Var eventData As New EventDataModel
		    EventDataModel.FromDictionary(ev, eventData)
		    events.Add(eventData)
		  Next
		  
		  Return events
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ReadComponents(station as StationModel)
		  Var apiClient As New BackendApiControllerClient
		  Var response As String = apiClient.Get("stations/" + station.Uid + "/components")
		  
		  Var components() As Variant = ParseJSON(response)
		  
		  For Each component As Dictionary In components
		    
		    Var doAdd As Boolean = False
		    
		    Var c As  ComponentModel = GetComponentByHardwareId(component.Value("HardwareId"))
		    If c = Nil Then
		      c = New ComponentModel
		      doAdd = True
		    End
		    
		    ComponentModel.FromDictionary(component, c)
		    
		    If doAdd Then
		      station.Components.Add(c)
		    End
		    
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ReadStations()
		  Var apiClient As New BackendApiControllerClient
		  Var response As String = apiClient.Get("stations")
		  
		  Var stations() As Variant = ParseJSON(response)
		  
		  For Each station As Dictionary In stations
		    
		    Var doAdd As Boolean = False
		    
		    Var s As StationModel = GetStationByUid(station.Value("Uid"))
		    If s = Nil Then
		      s = New StationModel
		      doAdd = True
		    End
		    
		    StationModel.FromDictionary(station, s)
		    ReadComponents(s)
		    
		    If doAdd Then
		      Self.Stations.Add(s)
		    End
		    
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ReadUsers()
		  Var apiClient As New BackendApiControllerClient
		  Var response As String = apiClient.Get("user")
		  
		  Var userDicts() As Variant = ParseJSON(response)
		  
		  For Each ud As Dictionary In userDicts
		    Var user As New UserModel
		    UserModel.FromDictionary(ud, user)
		    Self.Users.Add(user)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReloadComponent(componentUid as string) As ComponentModel
		  Var apiClient As New BackendApiControllerClient
		  Var response As String = apiClient.Get("components/" + componentUid)
		  
		  Var c As New ComponentModel
		  ComponentModel.FromJson(response, c)
		  
		  For Each station As StationModel In Self.Stations
		    For Each component As ComponentModel In station.Components
		      If component.HardwareId = c.HardwareId Then
		        component = c
		        Return component
		      End
		    Next
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UserLoggedOn(login as string)
		  Var apiClient As New BackendApiControllerClient
		  Var response As String = apiClient.Post("user/loggedOn/" + login, nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UserRequestPasswordReset(login as string)
		  Var apiClient As New BackendApiControllerClient
		  Var response As String = apiClient.Post("user/UserRequestPasswordReset/" + login, nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UserSetNewPassword(login as string, pwdHash as string)
		  Var apiClient As New BackendApiControllerClient
		  Var data As New JSONItem
		  data.Value("newPwdHash") = pwdHash
		  Var response As String = apiClient.Post("user/UserSetNewPassword/" + login, data)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Stations() As StationModel
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Users() As UserModel
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
