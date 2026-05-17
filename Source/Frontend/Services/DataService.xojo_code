#tag Class
Protected Class DataService
	#tag Method, Flags = &h0
		Sub ClearAlert(stationUid as string, user as string)
		  Var apiClient As New BackendApiControllerClient
		  Var data As New JSONItem
		  data.Value("user") = user
		  var response as string = apiClient.Post("station/" + stationUid + "/clearAlert", data)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetAggregations(type as string, hardwareId as string, take as integer = 0) As AggregationModel()
		  Var url As String = "aggregation/" + type + "/" + hardwareId
		  
		  If take > 0 Then
		    url = url + "?take=" + Str(take)
		  end
		  
		  Var apiClient As New BackendApiControllerClient
		  Var response As String = apiClient.Get(url)
		  
		  Var result() As AggregationModel
		  
		  Var aggregations() As Variant = ParseJSON(response)
		  
		  For Each agg As Dictionary In aggregations
		    Var a As New AggregationModel
		    AggregationModel.FromDictionary(agg, a)
		    result.Add(a)
		  Next
		  
		  Return result
		End Function
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
		Function GetCachedComponentByHardwareId(hardwareId as string) As ComponentModel
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
		Function GetCachedStationByUid(uid as string) As StationModel
		  For Each station As StationModel In Self.Stations
		    If station.Uid = uid Then
		      Return station
		    End
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCachedUserByLogin(login as string) As UserModel
		  For Each user As UserModel In Self.Users
		    If user.Login = login Then
		      Return user
		    End
		  Next
		  return nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetComponents(station as StationModel) As ComponentModel()
		  // reads all components from Component table of the given station
		  
		  Var apiClient As New BackendApiControllerClient
		  Var response As String = apiClient.Get("components/station/" + station.Uid)
		  
		  Var components() As Variant = ParseJSON(response)
		  Var result() As ComponentModel
		  
		  For Each component As Dictionary In components
		    Var c As  New ComponentModel
		    ComponentModel.FromDictionary(component, c)
		    result.Add(c)
		  Next
		  
		  Return result
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
		Function GetUserByPasskeyRequestCode(resetCode as string) As UserModel
		  Var apiClient As New BackendApiControllerClient
		  Var response As String = apiClient.Get("user/byPasskeyRequestCode/" + resetCode)
		  Var user As New UserModel
		  UserModel.FromJson(response, user)
		  Return user
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
		Function GetUsers(doReloadFromBackend as boolean = false) As UserModel()
		  // User Objekte werden gecached und nur beim ersten Aufruf vom Backend geladen.
		  If Self.Users.Count = 0 or doReloadFromBackend Then
		    ReadAndCacheUsers()
		  End
		  
		  Self.users.Sort(AddressOf SortUsers)
		  
		  Return Self.Users
		End Function
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

	#tag Method, Flags = &h0
		Sub ReadAndCacheStationsAndComponents()
		  Var apiClient As New BackendApiControllerClient
		  
		  Var r1 As String = apiClient.Get("station")
		  Var stations() As Variant = ParseJSON(r1)
		  
		  Var r2 As String = apiClient.Get("/components/last")
		  Var components() As Variant = ParseJSON(r2)
		  
		  UpdateStationsCache(stations, components)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ReadAndCacheUsers()
		  Var apiClient As New BackendApiControllerClient
		  Var response As String = apiClient.Get("user")
		  
		  Self.users.RemoveAll
		  
		  Var userDicts() As Variant = ParseJSON(response)
		  
		  For Each ud As Dictionary In userDicts
		    Var user As New UserModel
		    UserModel.FromDictionary(ud, user)
		    Self.Users.Add(user)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ReadStation(stationUid as string)
		  Var apiClient As New BackendApiControllerClient
		  Var response As String = apiClient.Get("station/" + stationUid)
		  If response.Length > 0 Then
		    Var s As StationModel = GetCachedStationByUid(stationUid)
		    StationModel.FromJson(response, s)
		  End
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveComponent(component as ComponentModel, executingLogin as string)
		  Var apiClient As New BackendApiControllerClient
		  Var response As String = apiClient.Delete("components/" + component.HardwareId, executingLogin)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveStation(station as stationModel, executingLogin as string)
		  Var apiClient As New BackendApiControllerClient
		  Var response As String = apiClient.Delete("station/" + station.Uid, executingLogin)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveUser(user as UserModel, executingLogin as string)
		  Var apiClient As New BackendApiControllerClient
		  Var response As String = apiClient.Delete("user/" + user.Login, executingLogin)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetMaintenanceMode(station as stationModel, start as boolean, executingLogin as string)
		  Var apiClient As New BackendApiControllerClient
		  Var response As String = apiClient.Post("station/" + station.Uid + "/" + if(start, "startMaintenance", "endMaintenance"), nil, executingLogin)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SortUSers(a as UserModel, b as UserModel) As Integer
		  If a.Name > b.Name Then Return 1
		  If a.Name < b.Name Then Return -1
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateComponentsCache(station as StationModel, components() as Variant)
		  // add and update cached components
		  For Each component As Dictionary In components
		    If component.Value("StationUid") = station.Uid Then
		      
		      Var doAdd As Boolean = False
		      
		      Var c As  ComponentModel = GetCachedComponentByHardwareId(component.Value("HardwareId"))
		      If c = Nil Then
		        c = New ComponentModel
		        doAdd = True
		      End
		      
		      ComponentModel.FromDictionary(component, c)
		      
		      If doAdd Then
		        station.Components.Add(c)
		      End
		      
		    End
		  Next
		  
		  Log.Debug(Str(station.Components.Count) + " components in cache for station " + station.DisplayName)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateStationsCache(stations() as Variant, components() as Variant)
		  For Each station As Dictionary In stations
		    
		    Var doAdd As Boolean = False
		    
		    Var s As StationModel = GetCachedStationByUid(station.Value("Uid"))
		    If s = Nil Then
		      s = New StationModel
		      doAdd = True
		    End
		    
		    StationModel.FromDictionary(station, s)
		    UpdateComponentsCache(s, components)
		    
		    If doAdd Then
		      Self.Stations.Add(s)
		    End
		    
		  Next
		  
		  Log.Debug(Str(Self.Stations.Count) + " stations in cache.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UserLoggedOn(login as string)
		  Var apiClient As New BackendApiControllerClient
		  Var response As String = apiClient.Post("user/loggedOn/" + login, nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UserRequestPasskey(login as string)
		  Var apiClient As New BackendApiControllerClient
		  Var response As String = apiClient.Post("user/requestPasskey/" + login, nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UserRequestPasswordReset(login as string)
		  Var apiClient As New BackendApiControllerClient
		  Var response As String = apiClient.Post("user/requestPasswordReset/" + login, nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UserSetNewPasskey(login as string, passkeyHash as string)
		  Var apiClient As New BackendApiControllerClient
		  Var data As New JSONItem
		  data.Value("newPasskeyHash") = passkeyHash
		  Var response As String = apiClient.Post("user/setNewPasskey/" + login, data)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UserSetNewPassword(login as string, pwdHash as string)
		  Var apiClient As New BackendApiControllerClient
		  Var data As New JSONItem
		  data.Value("newPwdHash") = pwdHash
		  Var response As String = apiClient.Post("user/setNewPassword/" + login, data)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub WriteComponent(component as ComponentModel, executingLogin as string)
		  Var apiClient As New BackendApiControllerClient
		  Var response As String = apiClient.Post("components", component.ToJson, executingLogin)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub WriteStation(station as StationModel, executingLogin as string)
		  Var apiClient As New BackendApiControllerClient
		  Var response As String = apiClient.Post("stations", station.ToJson, executingLogin)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub WriteUser(user as UserModel, executingLogin as string)
		  Var apiClient As New BackendApiControllerClient
		  Var response As String = apiClient.Post("user", user.ToJson, executingLogin)
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
