#tag Module
 Attributes ( "@Guid" = "9EAC44D8-DF52-4CCD-9682-D03904F6F013", "@Version" = "1.1", "@Author" = "Stefan Watermann", "@Copyright" = "(c)2023 watermann IT, Germany", "@Depends" = "File", "@Description" = "Drop-In Modul erweitert die WebApplication Klasse um Methoden eine Configuration-Datei zu verwalten." ) Protected Module WebConfiguration
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Function ConfigValue(extends app as WebApplication, key as string, defaultValue as Variant = "") As Variant
		  If KeyValueList.HasKey(key.Lowercase) Then
		    Return KeyValueList.Value(key.Lowercase)
		  Else
		    LogUsingDefaultValue(key)
		    Return defaultValue
		  End
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EnvValue(extends app as WebApplication, name as string, default as String = "") As String
		  Var s As String = System.EnvironmentVariable(name).Trim
		  If s <> "" Then 
		    Return s
		  ElseIf s = "" And default <> "" Then 
		    Return Default
		  End
		  Raise New RuntimeException("Environment variable '" + name + "' not found and no default value given.")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LogUsingDefaultValue(key as string)
		  //System.Log(System.LogLevelWarning, "Key '" + key + "' not in config, using default value.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ReadConfigFile(raiseErrorIfConfigFileMissing as Boolean = false)
		  ConfigHasBeenRead = False
		  
		  // init internal key/value dictionary
		  mKeyValueList = New Dictionary
		  
		  // create config-file name and FolderItem
		  Var cfgFileName As String = app.ExecutableFile.Name + ".config"
		  Var f As FolderItem = App.ExecutableFile.Parent.Child(cfgFileName)
		  
		  // exit (or raise error) if config-file not available
		  If f = Nil Or Not f.Exists Then
		    Var msg As String = "Config file '" + cfgFileName + "' does not exist, default values will be used."
		    If raiseErrorIfConfigFileMissing Then
		      Raise New RuntimeException(msg, 9909)
		    Else
		      System.Log(System.LogLevelWarning, msg)
		      Return
		    End
		  End
		  
		  // read config-file
		  Var lines() As String = File.ReadAllLines(f)
		  
		  // fill internal key/value dictionary
		  For Each line As String In lines
		    
		    If Not line.TrimLeft.BeginsWith("#") And line.Contains("=") Then
		      
		      Var indexSeparator As Integer = line.IndexOf("=")
		      
		      Var key As String = line.Left(indexSeparator).Trim.Lowercase
		      Var value As String = line.Right(line.length - indexSeparator - 1).Trim
		      
		      mKeyValueList.Value(key) = value
		      
		    End
		    
		  Next
		  
		  ConfigHasBeenRead = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Tests()
		  Print("TEST = " + App.ConfigValue("test", "Hello").StringValue)
		  Print("TEST1 = " + App.ConfigValue("test1", "Hello"))
		  Print("TEST2 = " + Str(App.ConfigValue("Test2", False).BooleanValue))
		  Print("TEST3 = " + Str(App.ConfigValue("teSt3").DoubleValue))
		  Print("TEST4 = " + Str(App.ConfigValue("teSt4").IntegerValue))
		  Print("D = " + App.ConfigValue("d", DateTime.now.SQLDate))
		  Print("DT = " + App.ConfigValue("dt", DateTime.now))
		  Print("Color = " + Str(App.ConfigValue("color").ColorValue))
		End Sub
	#tag EndMethod


	#tag Note, Name = Dependencies
		Depends on packages:
		  - File
		
	#tag EndNote

	#tag Note, Name = Readme
		Drop-In Modul erweitert die WebApplication Klasse um Methoden eine Configuration-Datei zu verwalten.
		
		Eine Config-Datei enthält zeilenweise Key/Value Paare der Art: key = value
		Das Zeichen # dient als Kommentarzeichen, leere Zeilen werden übersprüngen.
		Key Werte werden intern als lowercase gespeichert. Keys müssen unique sein.
		
		Die Config-Datei hat den selben Namen wie das Executable der App, mit dem Zusatz ".config".
		Hat das Executable den Namen "MyApp.app", dann hat die Konfigdatei den Namen "MyApp.app.config".
		Im Debug-Mode ist im Namen der App ".debug" enthalten, sodass eine separate COnfig Datei für
		Debugzwecke angelegt werden muss.
		
		Existiert die Config-Datei nicht, so liefern alle ConfigValue Methoden den DefaultValue zurück.
		
		Ab V1.1: 
		Zugriff auf Umgebungsvariablen mit App.EnvValue(name, defaultValue).
		Ist die genannte Umgebunsgvariable nicht vorhanden oder leer udn kein defaultValue angegeben,
		wird eine RuntimeException ausgelöst.
		
		Verwendung:
		-----------
		  var keyA as String = App.ConfigValue("keyA", "Hello").StringValue
		  var keyB as Boolean = App.ConfigValue("keyB").BooleanValue
		
		
		Unterstützt sind die Datentypen:
		 - String
		 - Integer
		 - Double
		 - Boolean
		 - Color
		 - DateTime
		
	#tag EndNote

	#tag Note, Name = Test.config
		test1 = Hallo Welt
		test2 =True
		Test3   = 0.000123
		test4=1234
		color = &c123456
		d = 2023-11-01
		dt = 2023-12-31 12:01:59
		
		
	#tag EndNote


	#tag Property, Flags = &h21
		Private ConfigHasBeenRead As Boolean = False
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  If Not ConfigHasBeenRead Then
			    ReadConfigFile
			  End
			  
			  Return mKeyValueList
			End Get
		#tag EndGetter
		Private KeyValueList As Dictionary
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mKeyValueList As Dictionary
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
End Module
#tag EndModule
