#tag WebContainerControl
Begin WebContainer ToolbarContainer
   Compatibility   =   ""
   ControlCount    =   0
   ControlID       =   ""
   CSSClasses      =   ""
   Enabled         =   True
   Height          =   40
   Indicator       =   0
   LayoutDirection =   0
   LayoutType      =   0
   Left            =   0
   LockBottom      =   False
   LockHorizontal  =   False
   LockLeft        =   True
   LockRight       =   False
   LockTop         =   True
   LockVertical    =   False
   PanelIndex      =   0
   ScrollDirection =   0
   TabIndex        =   0
   Top             =   0
   Visible         =   True
   Width           =   300
   _mDesignHeight  =   0
   _mDesignWidth   =   0
   _mName          =   ""
   _mPanelIndex    =   -1
   Begin WebButton btnLogonLogOff
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "L"
      ControlID       =   ""
      CSSClasses      =   ""
      Default         =   False
      Enabled         =   True
      Height          =   40
      Index           =   -2147483648
      Indicator       =   9
      Left            =   265
      LockBottom      =   False
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      Outlined        =   False
      PanelIndex      =   0
      Parent          =   "nil"
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   "Abmelden"
      Top             =   0
      Visible         =   True
      Width           =   35
      _mPanelIndex    =   -1
   End
   Begin WebButton btnMap
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "M"
      ControlID       =   ""
      CSSClasses      =   "bi bi-map"
      Default         =   False
      Enabled         =   True
      Height          =   40
      Index           =   -2147483648
      Indicator       =   9
      Left            =   230
      LockBottom      =   False
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      Outlined        =   False
      PanelIndex      =   0
      Parent          =   "nil"
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   "Karte"
      Top             =   0
      Visible         =   True
      Width           =   35
      _mPanelIndex    =   -1
   End
   Begin WebButton btnHome
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "H"
      ControlID       =   ""
      CSSClasses      =   "bi bi-house"
      Default         =   False
      Enabled         =   True
      Height          =   40
      Index           =   -2147483648
      Indicator       =   9
      Left            =   195
      LockBottom      =   False
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      Outlined        =   False
      PanelIndex      =   0
      Parent          =   "nil"
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   "Home"
      Top             =   0
      Visible         =   True
      Width           =   35
      _mPanelIndex    =   -1
   End
   Begin WebButton btnReload
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "R"
      ControlID       =   ""
      CSSClasses      =   "bi bi-arrow-clockwise"
      Default         =   False
      Enabled         =   True
      Height          =   40
      Index           =   -2147483648
      Indicator       =   9
      Left            =   160
      LockBottom      =   False
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      Outlined        =   False
      PanelIndex      =   0
      Parent          =   "nil"
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   "Daten neu laden"
      Top             =   0
      Visible         =   False
      Width           =   35
      _mPanelIndex    =   -1
   End
   Begin WebButton btnCurrentUser
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "-"
      ControlID       =   ""
      CSSClasses      =   "header-toolbar-userlink"
      Default         =   False
      Enabled         =   True
      Height          =   40
      Index           =   -2147483648
      Indicator       =   9
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      Outlined        =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   4
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Visible         =   True
      Width           =   160
      _mPanelIndex    =   -1
   End
End
#tag EndWebContainerControl

#tag WindowCode
	#tag Method, Flags = &h0
		Sub Refresh()
		  btnHome.Visible = Session.Authenticator.IsAuthenticatedUser
		  btnMap.Visible = Session.Authenticator.IsAuthenticatedUser
		  //btnReload.Visible = Session.Authenticator.IsAuthenticatedUser
		  
		  If Session.CurrentPage <> Nil Then
		    btnLogonLogOff.Visible = Session.CurrentPage.Name <> "PageLogon" and session.CurrentPage.Name <> "PagePasswordReset"
		  end
		End Sub
	#tag EndMethod


#tag EndWindowCode

#tag Events btnLogonLogOff
	#tag Event
		Sub Shown()
		  Refresh
		End Sub
	#tag EndEvent
	#tag Event
		Sub Pressed()
		  If Session.Authenticator.IsAuthenticatedUser Then
		    Session.Authenticator.ClearCurrentUser
		    GoToURL("/")
		  end
		End Sub
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.Caption = ""
		  Me.CSSClasses.Remove("bi-box-arrow-left")
		  Me.CSSClasses.Remove("bi-box-arrow-right")
		  Me.CSSClasses.Add("bi")
		  Me.CSSClasses.Add("bi-box-arrow-left")
		  Me.Tooltip = "Abmelden"
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnMap
	#tag Event
		Sub Shown()
		  Refresh
		End Sub
	#tag EndEvent
	#tag Event
		Sub Pressed()
		  GoToURL("#map")
		End Sub
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.Caption = ""
		  Refresh
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnHome
	#tag Event
		Sub Shown()
		  Refresh
		End Sub
	#tag EndEvent
	#tag Event
		Sub Pressed()
		  GoToURL("#station")
		End Sub
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.Caption = ""
		  Refresh
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnReload
	#tag Event
		Sub Shown()
		  Refresh
		End Sub
	#tag EndEvent
	#tag Event
		Sub Pressed()
		  App.DataSvc.LoadStations
		  Session.CurrentPage.UpdateBrowser
		  // TODO Seite neu laden, bzw. aktualisieren
		End Sub
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.Caption = ""
		  Refresh
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnCurrentUser
	#tag Event
		Sub Shown()
		  If session.CurrentUser <> Nil Then
		    me.Visible = True
		    Me.Caption = Session.CurrentUser.Name
		  Else
		    Me.Visible = False
		  End
		End Sub
	#tag EndEvent
	#tag Event
		Sub Pressed()
		  Var container As New UserInfoContainer(Session.CurrentUser)
		  container.ShowPopover(Me, WebContainer.DisplaySides.Bottom)
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
		Name="_mPanelIndex"
		Visible=false
		Group="Behavior"
		InitialValue="-1"
		Type="Integer"
		EditorType=""
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
		Name="LockBottom"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockHorizontal"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockVertical"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
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
		Name="ScrollDirection"
		Visible=true
		Group="Behavior"
		InitialValue="ScrollDirections.None"
		Type="WebContainer.ScrollDirections"
		EditorType="Enum"
		#tag EnumValues
			"0 - None"
			"1 - Horizontal"
			"2 - Vertical"
			"3 - Both"
		#tag EndEnumValues
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
		Name="LayoutType"
		Visible=true
		Group="View"
		InitialValue="LayoutTypes.Fixed"
		Type="LayoutTypes"
		EditorType="Enum"
		#tag EnumValues
			"0 - Fixed"
			"1 - Flex"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="LayoutDirection"
		Visible=true
		Group="View"
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
	#tag ViewProperty
		Name="Width"
		Visible=false
		Group=""
		InitialValue="250"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=false
		Group=""
		InitialValue="250"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
