#tag WebPage
Begin WebDialog DialogExportRun
   Compatibility   =   ""
   ControlCount    =   0
   ControlID       =   ""
   CSSClasses      =   ""
   Enabled         =   True
   Height          =   140
   Index           =   -2147483648
   Indicator       =   0
   LayoutDirection =   0
   LayoutType      =   0
   Left            =   0
   LockBottom      =   False
   LockHorizontal  =   False
   LockLeft        =   False
   LockRight       =   False
   LockTop         =   False
   LockVertical    =   False
   PanelIndex      =   0
   Position        =   0
   TabIndex        =   0
   Top             =   0
   Visible         =   True
   Width           =   400
   _mDesignHeight  =   0
   _mDesignWidth   =   0
   _mPanelIndex    =   -1
   Begin WebProgressWheel ProgressWheel1
      Colorize        =   False
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      Height          =   40
      Index           =   -2147483648
      Indicator       =   0
      Left            =   55
      LockBottom      =   False
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      PanelIndex      =   0
      Scope           =   2
      SVGColor        =   &c00000000
      SVGData         =   ""
      TabIndex        =   1
      TabStop         =   True
      Tooltip         =   ""
      Top             =   50
      Visible         =   True
      Width           =   40
      _mPanelIndex    =   -1
   End
   Begin WebLabel lbInfo
      Bold            =   False
      ControlID       =   ""
      CSSClasses      =   "small align-middle "
      Enabled         =   True
      FontName        =   ""
      FontSize        =   0.0
      Height          =   60
      HTMLElement     =   6
      Index           =   -2147483648
      Indicator       =   0
      Italic          =   False
      Left            =   110
      LockBottom      =   False
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   True
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   2
      TabStop         =   True
      Text            =   "Einen Moment bitte, die Daten werden geladen..."
      TextAlignment   =   0
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   40
      Underline       =   False
      Visible         =   True
      Width           =   250
      _mPanelIndex    =   -1
   End
   Begin WebThread Thread1
      DebugIdentifier =   ""
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   True
      Priority        =   5
      Scope           =   2
      StackSize       =   0
      ThreadID        =   0
      ThreadState     =   0
      Type            =   0
   End
End
#tag EndWebPage

#tag WindowCode
	#tag Event
		Sub Shown()
		  Thread1.Start
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub DataReceived()
		  Self.Thread1.Stop
		  
		  self.UpdateBrowser
		  
		  Self.Visible = False
		  RaiseEvent ExportDataReady(Self.DownloadData)
		  Self.Close
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Show()
		  // Calling the overridden superclass method.
		  Super.Show()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Show(dtFrom as DateTime, dtTo as DateTime, componentTypes() as string, stations() as string)
		  Self.DtFrom = dtFrom
		  Self.DtTo = dtTo
		  Self.ComponentTypes = componentTypes
		  Self.Stations = stations
		  
		  // Calling the overridden superclass method.
		  Super.Show()
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ExportDataReady(data as MemoryBlock)
	#tag EndHook


	#tag Property, Flags = &h21
		Private ComponentTypes() As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private DownloadData As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private DownloadThreadResult As Pair
	#tag EndProperty

	#tag Property, Flags = &h21
		Private DtFrom As DateTime
	#tag EndProperty

	#tag Property, Flags = &h21
		Private DtTo As DateTime
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Stations() As String
	#tag EndProperty


#tag EndWindowCode

#tag Events Thread1
	#tag Event
		Sub Run()
		  Try
		    
		    Log.Info("Preparing data-export.", CurrentMethodName)
		    MyProfiler.Start(CurrentMethodName)
		    
		    If Self.ComponentTypes.Count = 1 And Self.ComponentTypes(0) = "FL" Then
		      // nur Faults/Alerts exportieren
		      Var data() As AlertModel = App.DataSvc.GetAlerts(Self.Stations, Self.DtFrom, Self.DtTo)
		      DownloadData = AlertModel.CreateCsvString(data)
		      
		    Else
		      // Components exportieren
		      Var data() As EventDataExportModel = App.DataSvc.GetEventDataExport(Self.Stations, Self.ComponentTypes, Self.DtFrom, Self.DtTo, Session.CurrentUser.Login)
		      DownloadData = EventDataExportModel.CreateCsvString(data)
		      
		    End
		    
		    Log.Info("Export data received.", CurrentMethodName)
		    MyProfiler.Stop(CurrentMethodName)
		    
		    Self.DownloadThreadResult = New Pair("success", "")
		    
		  Catch ex As RuntimeException
		    Self.DownloadThreadResult = New Pair("failed", "Die Datei konnte nicht erzeugt werden. Fehler: " + ex.Message)
		    
		  Finally
		    Me.AddUserInterfaceUpdate()
		    
		  End
		  
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub UserInterfaceUpdate(data() As Dictionary)
		  If Self.DownloadThreadResult.Left = "success" Then
		    Log.Info("Export ready, " + Str(Self.DownloadData.Size) + " Byte loaded.", CurrentMethodName)
		    
		    DataReceived
		    
		  Else
		    MessageBox(Self.DownloadThreadResult.Right)
		  end
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="PanelIndex"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Index"
		Visible=false
		Group="ID"
		InitialValue="-2147483648"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
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
		Name="Position"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="WebDialog.Positions"
		EditorType="Enum"
		#tag EnumValues
			"0 - Top"
			"1 - Center"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="ControlCount"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_mPanelIndex"
		Visible=false
		Group="Behavior"
		InitialValue="-1"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ControlID"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Enabled"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Behavior"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LayoutType"
		Visible=true
		Group="Behavior"
		InitialValue="LayoutTypes.Fixed"
		Type="LayoutTypes"
		EditorType="Enum"
		#tag EnumValues
			"0 - Fixed"
			"1 - Flex"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockHorizontal"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockVertical"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Behavior"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_mDesignHeight"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_mDesignWidth"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_mName"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIndex"
		Visible=true
		Group="Visual Controls"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Indicator"
		Visible=false
		Group="Visual Controls"
		InitialValue=""
		Type="WebUIControl.Indicators"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Primary"
			"2 - Secondary"
			"3 - Success"
			"4 - Danger"
			"5 - Warning"
			"6 - Info"
			"7 - Light"
			"8 - Dark"
			"9 - Link"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="LayoutDirection"
		Visible=true
		Group="WebView"
		InitialValue="LayoutDirections.LeftToRight"
		Type="LayoutDirections"
		EditorType="Enum"
		#tag EnumValues
			"0 - LeftToRight"
			"1 - RightToLeft"
			"2 - TopToBottom"
			"3 - BottomToTop"
		#tag EndEnumValues
	#tag EndViewProperty
#tag EndViewBehavior
