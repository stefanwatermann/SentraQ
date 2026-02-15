#tag Module
Protected Module Log
	#tag Method, Flags = &h0
		Sub Critical(msg as string, origin as string = "default")
		  // critical wird unabhängig vom LogLevel ausgegeben
		  
		  Var m As String = "CRL [" + origin + "]: " + msg
		  
		  Enqueue(m, "CRITICAL")
		  
		  System.Log(System.LogLevelCritical, m)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Debug(msg as string, origin as string = "default")
		  If Level = Log.LogLevel.DEBUG Then
		    
		    Var m As String = "DBG [" + origin + "]: " + msg
		    
		    Enqueue(m, "DEBUG")
		    
		    If Not PrintOnly Then
		      System.Log(System.LogLevelDebug, m)
		    End
		    
		  End
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Enqueue(m as string, lvl as string)
		  // Not used
		  Return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Error(msg as string, origin as string = "default")
		  // critical wird unabhängig vom LogLevel ausgegeben
		  
		  Var m As String = "ERR [" + origin + "]: " + msg
		  
		  Enqueue(m, "ERROR")
		  
		  If Not PrintOnly Then
		    System.Log(System.LogLevelError, m)
		  End
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Info(msg as string, origin as string = "default")
		  If Level = Log.LogLevel.DEBUG Or Level = Log.LogLevel.INFO Then
		    
		    Var m As String = "INF [" + origin + "]: " + msg
		    
		    Enqueue(m, "INFO")
		    
		    If Not PrintOnly Then
		      System.Log(System.LogLevelInformation, m)
		    End
		    
		  End
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function NewGuid() As String
		  //System.DebugLog(CurrentMethodName)
		  
		  // From http://www.cryptosys.net/pki/uuid-rfc4122.html
		  //
		  // Generate 16 random bytes (=128 bits)
		  // Adjust certain bits according to RFC 4122 section 4.4 as follows:
		  // set the four most significant bits of the 7th byte to 0100'B, so the high nibble is '4'
		  // set the two most significant bits of the 9th byte to 10'B, so the high nibble will be one of '8', '9', 'A', or 'B'.
		  // Convert the adjusted bytes to 32 hexadecimal digits
		  // Add four hyphen '-' characters to obtain blocks of 8, 4, 4, 4 and 12 hex digits
		  // Output the resulting 36-character string "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
		  
		  Dim randomBytes As MemoryBlock = Crypto.GenerateRandomBytes(16)
		  randomBytes.LittleEndian = False
		  
		  //
		  // Adjust seventh byte
		  //
		  Dim value As Byte = randomBytes.Byte(6)
		  value = value And &b00001111 // Turn off the first four bits
		  value = value Or &b01000000 // Turn on the second bit
		  randomBytes.Byte(6) = value
		  
		  //
		  // Adjust ninth byte
		  //
		  value = randomBytes.Byte(8)
		  value = value And &b00111111 // Turn off the first two bits
		  value = value Or &b10000000 // Turn on the first bit
		  randomBytes.Byte(8) = value
		  
		  
		  Dim result As String = EncodeHex(randomBytes)
		  result = result.LeftB(8) + "-" + result.MidB(9, 4) + "-" + result.MidB(13, 4) + "-" + result.MidB(17, 4) + _
		  "-" + result.RightB(12)
		  
		  Return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetAppIdent(name as string)
		  AppIdent = name
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetLogLevel(logLevel as string)
		  Select Case logLevel.Trim.Lowercase
		    
		  Case "info"
		    Level = Log.LogLevel.INFO
		    
		  Case "warn"
		    Level = Log.LogLevel.WARN
		    
		  Case "error"
		    Level = Log.LogLevel.ERROR
		    
		  Else
		    Level = Log.LogLevel.DEBUG
		    
		  End
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Warning(msg as string, origin as string = "default")
		  If Level = Log.LogLevel.DEBUG Or Level = Log.LogLevel.INFO Or Level = Log.LogLevel.WARN Then
		    
		    Var m As String = "WRN [" + origin + "]: " + msg
		    
		    Enqueue(m, "WARN")
		    
		    If Not PrintOnly Then
		      System.Log(System.LogLevelWarning, m)
		    End
		    
		  End
		End Sub
	#tag EndMethod


	#tag Note, Name = Histroy
		1.0.5 - 2024-08-18
		------------------
		- Async LogQueue
		- get hostname as InstId when runing as WebApp
		
		
		1.0.2 - 2023-10-29
		------------------
		- LogLevel
		
		
		1.0.1 - 2023-10-19
		------------------
		- new parameter "origin"
		- same message for Print() and System.Log()
		
	#tag EndNote

	#tag Note, Name = Linux
		UrlConnection unter Linux (und Raspi)
		=====================================
		
		https://forum.xojo.com/t/how-do-i-install-libsoup-2-4/39182
		
		libsoup muss vorhanden sein
		
		sudo apt-get install libsoup2.4
		
		——
		
		Prüfen ob vorhanden
		
		ldconfig -p | grep libsoup
	#tag EndNote

	#tag Note, Name = Usage
		In App.Open event or as early as possible in app:
		
		// init logging, mandatory!
		Log.SetLogAgentUrl("https://www.watermann-it.de/ws/logreceiver.php")
		Log.SetAppIdent("MyAppIdentName")
		Log.SetLogLevel("INFO")
		Log.SendOnline = True
		
		Then use:
		Log.Info(..)
		Log.Debug(..)
		Log.Error(..)
		...
		
		
	#tag EndNote


	#tag Property, Flags = &h21
		Private AppIdent As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  return str(app.MajorVersion) + "." + str(app.MinorVersion) + "." + str(app.BugVersion) + "." + str(app.NonReleaseVersion)
			End Get
		#tag EndGetter
		Private AppVersion As string
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private InstId As string = "default"
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Level As Log.LogLevel
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  #If DebugBuild Then
			    Return True
			  #Else
			    Return False
			  #EndIf
			End Get
		#tag EndGetter
		Private PrintOnly As Boolean
	#tag EndComputedProperty


	#tag Enum, Name = LogLevel, Type = Integer, Flags = &h0
		DEBUG
		  INFO
		  WARN
		ERROR
	#tag EndEnum


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
