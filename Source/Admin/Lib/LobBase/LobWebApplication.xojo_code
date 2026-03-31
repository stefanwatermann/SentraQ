#tag Class
Protected Class LobWebApplication
Inherits WebApplication
	#tag Event
		Function HandleURL(request As WebRequest, response As WebResponse) As Boolean
		  Var requestHandled As Boolean = False
		  
		  // Verify we have a valid path so as not to catch blank GET requests.
		  If Request.Path = "" Then
		    Return False
		  End If
		  
		  // handle status-api requests
		  If Not requestHandled And mStatusRequestSvc.IsStatusApiRequest(request) Then
		    mStatusRequestSvc.CustomStatusApiData.Value("AppProcessGuid") = AppProcessGuid
		    RaiseEvent UpdateCustomStatusRequestApiData(mStatusRequestSvc.CustomStatusApiData)
		    requestHandled = mStatusRequestSvc.HandleStatusRequest(request, response)
		  End
		  
		  // handle static content from /Html folder
		  If Not requestHandled and Request.Path.BeginsWith("Html") Then
		    requestHandled = Self.HandleStaticContent(request, response, App.ExecutableFile.Parent)
		  End
		  
		  /// call handler on App level
		  If Not requestHandled Then
		    requestHandled = RaiseEvent HandleUrl(request, response)
		  End
		  
		  Return requestHandled
		End Function
	#tag EndEvent

	#tag Event
		Sub Opening(args() As String)
		  // Raise Open Handler
		  RaiseEvent Opening(args)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function HandleStaticContent(Request As WebRequest, Response As WebResponse, Folder As FolderItem, MIMEType As String = "application/octet-stream") As Boolean
		  // Based on: XojoWeb_StaticContent
		  // See: https://github.com/1701software/XojoWeb_StaticContent
		  
		  // do allow browser access to the HTML folder only
		  // return 404 to not indicate that the requested resource exist
		  If Not Request.Path.Uppercase.BeginsWith("HTML/") Then
		    response.Reset
		    response.Status = 404
		    Return True
		  End
		  
		  // Determine if we have a file that matches this path.
		  Dim _filePath As String
		  _filePath = Request.Path
		  #If TargetWindows = True Then
		    _filePath = _filePath.ReplaceAll("/", "\")
		  #EndIf
		  
		  Dim _folderPath As String
		  _folderPath = Folder.NativePath
		  #If TargetWindows = True Then
		    _folderPath = _folderPath + "\"
		  #ElseIf TargetLinux = True Or TargetMacOS = True Then
		    _folderPath = _folderPath + "/"
		  #EndIf
		  
		  Dim _fullPath As String
		  _fullPath = _folderPath + _filePath
		  
		  Dim _fileInFolder As FolderItem
		  _fileInFolder = GetFolderItem(_folderPath + _filePath, FolderItem.PathTypeNative)
		  
		  If (_fileInFolder = Nil) Then
		    Return False
		  End If
		  
		  If (_fileInFolder.Exists() = False) Then
		    Return False
		  End If
		  
		  // We got this far which means there is a file that matches this request path. Let's set the request MIME type.
		  If _fileInFolder.Name.Lowercase().EndsWith(".css") Then
		    Response.MIMEType = "text/css"
		  ElseIf _fileInFolder.Name.Lowercase().EndsWith(".js") Then
		    Response.MIMEType = "application/javascript"
		  ElseIf _fileInFolder.Name.Lowercase().EndsWith(".png") Then
		    Response.MIMEType = "image/png"
		  Else
		    Response.MIMEType = "text/html"
		  End If
		  
		  // We should also update the status code because some browsers are picky about this.
		  Response.Status = 200 // HTTP OK
		  
		  // Read the file contents and append to the request.
		  Dim _fileStream As BinaryStream
		  _fileStream = BinaryStream.Open(_fileInFolder)
		  
		  Response.Write(_fileStream.Read(_fileStream.Length))
		  
		  // Return True so Xojo Web sends the file down to the browser.
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InitApp(name as string, company as string, statusServiceApiKey as string = "")
		  Self.mAppProcessGuid = NewGuid
		  Self.mAppName = name
		  Self.mAppCompany = company
		  Self.mStatusRequestServiceApiKey = statusServiceApiKey
		  
		  // Init Status Service
		  mStatusRequestSvc = New StatusRequestService(App.AppVersion, "api/status", mStatusRequestServiceApiKey)
		  
		  // Init logging
		  Log.SetAppIdent(Self.AppName)
		  Log.SetLogLevel(App.ConfigValue("Logging.LogLevel", "INFO"))
		  Log.Info("App '" + appName + "' started.", CurrentMethodName)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event HandleUrl(request as WebRequest, response as WebResponse) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Opening(args() as String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event UpdateCustomStatusRequestApiData(statusRequestApiData as Dictionary)
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mAppCompany
			End Get
		#tag EndGetter
		AppCompany As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return "(c) " + str(DateTime.Now.Year) + " " + mAppCompany
			End Get
		#tag EndGetter
		AppCopyrightText As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return app.ExecutableFile.Parent.Child("Data")
			End Get
		#tag EndGetter
		AppDataFolder As FolderItem
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return app.ExecutableFile.Parent.Child("Html")
			End Get
		#tag EndGetter
		AppHtmlFolder As FolderItem
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mAppName
			End Get
		#tag EndGetter
		AppName As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mAppProcessGuid
			End Get
		#tag EndGetter
		AppProcessGuid As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Str(app.MajorVersion) + "." + Str(app.MinorVersion) + "." + Str(app.BugVersion) + "." + Str(app.NonReleaseVersion)
			End Get
		#tag EndGetter
		AppVersion As string
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mAppCompany As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAppName As String = "MyWebApp"
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAppProcessGuid As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStatusRequestServiceApiKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStatusRequestSvc As StatusRequestService
	#tag EndProperty


	#tag ViewBehavior
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
			Name="AppCompany"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
