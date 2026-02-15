#tag Module
 Attributes ( "@Guid" = "D5423704-BF1C-4128-9F7D-132DD08C2AF2", "@Author" = "Stefan Watermann", "@Copyright" = "(c)2025 Stefan Watermann", "@Version" = "1.1.1", "@Description" = "Extensions to the WebSession class." ) Protected Module WebSessionExtensions
	#tag Method, Flags = &h0
		Function Domain(extends s as WebSession) As string
		  If s.FQDN.Contains(":") Then
		    Return "." // localhost hack(??)
		  Else
		    Return s.FQDN
		  End
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746865206671646E2066726F6D2074686520486F737420487474702D486561646572
		Function FQDN(extends s as WebSession) As String
		  Var host As String
		  For i As Integer = 0 To s.HeaderCount
		    If s.HeaderAt(i) = "Host" Then
		      host = s.Header(session.HeaderAt(i))
		      Exit
		    End
		  Next
		  
		  If host <> "" Then
		    Return host
		  End
		  
		  Return "unknown"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetJavaScriptError(Extends s as Session, errorName as string, errorMessage as string, errorStack as string) As String
		  Var msg As String = "JavaScript error (SID=" + s.Identifier + "): " + errorName + &u0A + errorMessage + &u0A + errorStack
		  
		  Try
		    
		    //Current page
		    If s.CurrentPage <> Nil Then
		      Dim name As String
		      Dim type As Introspection.TypeInfo = Introspection.GetType(Session.CurrentPage)
		      name = type.Name
		    End If
		    
		    //URL parameters
		    If s.URLParameterCount > 0 Then
		      Dim parameterName, value As String
		      Dim params() As String
		      For i As Integer = 0 To s.URLParameterCount - 1
		        parameterName = s.URLParameterName(i)
		        value = s.URLParameter(parameterName)
		        params.Add parameterName + "=" + value
		      Next
		      
		      msg = msg + ", URL=" + app.URL + "?" + String.FromArray(params, "&") + If(s.HashTag.IsEmpty, "", "#" + s.HashTag)
		    Else
		      msg = msg + ", URL=" + app.URL + If(s.HashTag.IsEmpty, "", "#" + s.HashTag)
		    End If
		    
		    If s.HashTag.IsEmpty = False Then
		      msg = msg + ", HashTag=" + s.HashTag
		    End If
		    
		    msg = msg + ", LanguageCode=" + s.LanguageCode
		    
		    msg = msg + ", Session.RawHeaders=" + s.RawHeaders
		    
		  Catch err
		    //Make sure we do not create another exception by sending it to Sentry
		    msg = msg + " [InternalError: " + err.Message + "]"
		  End Try
		  
		  Return msg
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320616C6C20636F6F6B696573206173206120737472696E67
		Function RawCookies(extends s as WebSession) As String
		  If s.Cookies.Count = 0 Then Return "-"
		  
		  Var cookies() As String
		  For i As Integer = 0 To s.Cookies.Count - 1
		    Var name As String = s.Cookies.NameAt(i)
		    cookies.Add(name + " = " + s.Cookies.Value(name))
		  Next
		  
		  Return String.FromArray(cookies, EndOfLine)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ShowUnhandledSessionError(Extends s as Session, err as RuntimeException) As Boolean
		  Try
		    Var msg As String = "Session crashed (SID=" + s.SecureSessionId + "): [" + Str(err.ErrorNumber) + "] " + err.Message + " (" + String.FromArray(err.Stack, ", ") + ")"
		    
		    Var dlg As New DialogErrorMessage
		    dlg.Show( _
		    "Eine Aktion konnte nicht erfolgreich ausgeführt werden." + EndOfLine + "Tritt dieser Fehler erneut auf, wenden Sie sich bitte mit dem hier aufgeführten Support-Code an uns.",_
		    msg,_
		    s.SecureSessionId)
		    
		  Catch e
		    //Make sure we do not create another exception
		    
		  End Try
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73207468652066697273742070617274206F6620746865206671646E2028652E672E20777777206966206671646E206973207777772E676F6F676C652E646529
		Function SubDomain(extends s as WebSession) As String
		  Var host As String = s.FQDN
		  
		  If host.CountFields(".") = 3 Then
		    Var r As String = host.NthField(".", 1)
		    Return r
		  End
		  
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UserAgent(extends s as WebSession) As String
		  Var a As String = s.Header("User-Agent")
		  Return a
		End Function
	#tag EndMethod


	#tag Note, Name = History
		v1.1.1 - 2025-08-06
		--------------------
		- new prop "Domain" handling localhost
		
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
