#tag Class
Protected Class BackendApiControllerClient
	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.MyUrlConnection = New URLConnection
		  Self.MyUrlConnection.RequestHeader(kControllerApiAuthKeyHeaderName) = Self.ControllerApiAuthKeyValue
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Get(path as string) As string
		  // backend-api must be online and configured correctly
		  
		  path = If(path.BeginsWith("/"), path, "/" + path)
		  
		  Var url As String = Self.ControllerApiUrl + "/api" + path
		  
		  Var response As String = Self.MyUrlConnection.SendSync("GET", url)
		  
		  If Self.HTTPStatusCode <> 200 Then
		    Raise New RuntimeException("GET request to '" + url + "'failed: [" + Str(Self.HttpStatusCode) + "] " + response)
		  End
		  
		  Return response
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Post(path as string, data as JSONItem) As String
		  path = If(path.BeginsWith("/"), path, "/" + path)
		  
		  Var url As String = Self.ControllerApiUrl + "/api" + path
		  
		  If data <> Nil Then
		    Self.MyUrlConnection.SetRequestContent(data.ToString, "application/json")
		  End
		  
		  Var response As String = Self.MyUrlConnection.SendSync("POST", url)
		  
		  If Self.HTTPStatusCode <> 200 Then
		    Raise New RuntimeException("POST request to '" + url + "'failed: [" + Str(Self.HttpStatusCode) + "] " + response)
		  End
		  
		  Return response
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  return App.ConfigValue("ControllerApi.AuthKeyValue")
			End Get
		#tag EndGetter
		Private ControllerApiAuthKeyValue As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Var url As String = App.ConfigValue("ControllerApi.Url")
			  If url.EndsWith("/") Then
			    Return url.Left(url.Length-1)
			  End
			  Return url
			End Get
		#tag EndGetter
		Private ControllerApiUrl As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.MyUrlConnection.HTTPStatusCode
			End Get
		#tag EndGetter
		HttpStatusCode As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private MyUrlConnection As URLConnection
	#tag EndProperty


	#tag Constant, Name = kControllerApiAuthKeyHeaderName, Type = String, Dynamic = False, Default = \"X-AUTH-KEY", Scope = Public
	#tag EndConstant


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
			Name="HttpStatusCode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
