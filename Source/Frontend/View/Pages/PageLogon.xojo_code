#tag WebPage
Begin LobBase.LobWebPage PageLogon
   AllowTabOrderWrap=   True
   Compatibility   =   ""
   ControlCount    =   0
   ControlID       =   ""
   CSSClasses      =   ""
   Enabled         =   False
   Height          =   500
   ImplicitInstance=   True
   Index           =   -2147483648
   Indicator       =   0
   IsImplicitInstance=   False
   LayoutDirection =   0
   LayoutType      =   0
   Left            =   0
   LockBottom      =   False
   LockHorizontal  =   False
   LockLeft        =   True
   LockRight       =   False
   LockTop         =   True
   LockVertical    =   False
   MinimumHeight   =   500
   MinimumWidth    =   320
   PanelIndex      =   0
   RequiresAuthenticatedUser=   False
   ScaleFactor     =   0.0
   TabIndex        =   0
   Title           =   "WWP - Logon"
   Top             =   0
   Visible         =   True
   Width           =   600
   _ImplicitInstance=   False
   _mDesignHeight  =   0
   _mDesignWidth   =   0
   _mPanelIndex    =   -1
   Begin WebButton btnLogon
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "Anmelden"
      ControlID       =   ""
      CSSClasses      =   ""
      Default         =   True
      Enabled         =   True
      Height          =   38
      Index           =   -2147483648
      Indicator       =   1
      Left            =   200
      LockBottom      =   False
      LockedInPosition=   True
      LockHorizontal  =   True
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Outlined        =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   2
      TabStop         =   True
      Tooltip         =   ""
      Top             =   250
      Visible         =   True
      Width           =   200
      _mPanelIndex    =   -1
   End
   Begin WebTextField tbUserName
      AllowAutoComplete=   False
      AllowSpellChecking=   False
      Caption         =   ""
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FieldType       =   0
      Height          =   38
      Hint            =   "Benutzername"
      Index           =   -2147483648
      Indicator       =   0
      Left            =   160
      LockBottom      =   False
      LockedInPosition=   True
      LockHorizontal  =   True
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      MaximumCharactersAllowed=   0
      PanelIndex      =   0
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   3
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   2
      Tooltip         =   ""
      Top             =   120
      Visible         =   True
      Width           =   280
      _mPanelIndex    =   -1
   End
   Begin WebTextField tbPassword
      AllowAutoComplete=   False
      AllowSpellChecking=   False
      Caption         =   ""
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FieldType       =   1
      Height          =   38
      Hint            =   "Passwort"
      Index           =   -2147483648
      Indicator       =   0
      Left            =   160
      LockBottom      =   False
      LockedInPosition=   True
      LockHorizontal  =   True
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      MaximumCharactersAllowed=   0
      PanelIndex      =   0
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   4
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   2
      Tooltip         =   ""
      Top             =   170
      Visible         =   True
      Width           =   280
      _mPanelIndex    =   -1
   End
   Begin WebLabel lbHint
      Bold            =   False
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   14.0
      Height          =   110
      Index           =   -2147483648
      Indicator       =   0
      Italic          =   False
      Left            =   161
      LockBottom      =   True
      LockedInPosition=   True
      LockHorizontal  =   True
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   True
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   5
      TabStop         =   True
      Text            =   "Fehler"
      TextAlignment   =   0
      TextColor       =   &c94110000
      Tooltip         =   ""
      Top             =   360
      Underline       =   False
      Visible         =   True
      Width           =   280
      _mPanelIndex    =   -1
   End
   Begin WebLabel lbCaption
      Bold            =   False
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   22.0
      Height          =   38
      Index           =   -2147483648
      Indicator       =   0
      Italic          =   False
      Left            =   160
      LockBottom      =   False
      LockedInPosition=   True
      LockHorizontal  =   True
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   6
      TabStop         =   True
      Text            =   "Anmelden"
      TextAlignment   =   2
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   60
      Underline       =   False
      Visible         =   True
      Width           =   280
      _mPanelIndex    =   -1
   End
   Begin WebButton btnNewPwd
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "Passwort vergessen"
      ControlID       =   ""
      CSSClasses      =   "small"
      Default         =   False
      Enabled         =   True
      Height          =   38
      Index           =   -2147483648
      Indicator       =   9
      Left            =   200
      LockBottom      =   False
      LockedInPosition=   True
      LockHorizontal  =   True
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Outlined        =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   7
      TabStop         =   True
      Tooltip         =   ""
      Top             =   310
      Visible         =   True
      Width           =   200
      _mPanelIndex    =   -1
   End
   Begin DialogYesNo DialogYesNo1
      ControlCount    =   0
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      Height          =   230
      Index           =   -2147483648
      Indicator       =   0
      LayoutDirection =   0
      LayoutType      =   0
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   False
      LockVertical    =   False
      PanelIndex      =   0
      Position        =   0
      Scope           =   2
      TabIndex        =   9
      TabStop         =   True
      Tooltip         =   ""
      Top             =   20
      Visible         =   True
      Width           =   400
      _mDesignHeight  =   0
      _mDesignWidth   =   0
      _mPanelIndex    =   -1
   End
   Begin FooterContainer FooterContainer1
      ControlCount    =   0
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      Height          =   30
      Index           =   -2147483648
      Indicator       =   0
      LayoutDirection =   0
      LayoutType      =   0
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      LockVertical    =   False
      PanelIndex      =   0
      Scope           =   2
      ScrollDirection =   0
      TabIndex        =   10
      TabStop         =   True
      Tooltip         =   ""
      Top             =   470
      Visible         =   True
      Width           =   560
      _mDesignHeight  =   0
      _mDesignWidth   =   0
      _mPanelIndex    =   -1
   End
End
#tag EndWebPage

#tag WindowCode
	#tag Event
		Sub Shown()
		  ShowHint("")
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub HandleTooManyLogons()
		  If FailedLogonCount > 5 Then
		    Log.Warning("Too many failed login attempts. Remote-IP: " + Session.RemoteAddress + "; HTTP-Header: " + Session.RawHeaders, Session.SecureSessionId)
		    Session.CurrentPage = PageNoAccess
		  End
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowHint(msg as string)
		  If msg.Trim <> "" Then
		    MessageBox("<raw><div class='text-center text-danger fs-5 mb-2'>Fehler</div><div class='text-center'>" + msg + "</div></raw>")
		  End
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = Readme
		WICHTIG: Die Konstante Session.kAuthenticationSalt muss individuell für die App geändert sein!
		
	#tag EndNote


	#tag Property, Flags = &h21
		Private FailedLogonCount As Integer = 0
	#tag EndProperty


#tag EndWindowCode

#tag Events btnLogon
	#tag Event
		Sub Pressed()
		  Try
		    ShowHint("")
		    
		    HandleTooManyLogons
		    
		    If tbUserName.Text = "" Or tbPassword.Text = "" Then
		      ShowHint("Bitte Benutzernamen und Passwort angeben.")
		      FailedLogonCount = FailedLogonCount + 1
		      
		    Else
		      Session.Authenticator.SetCurrentUser(tbUserName.Text, tbPassword.Text)
		      
		      If Session.Authenticator.IsAuthenticatedUser Then
		        Log.Info("User logged on: " + Session.Authenticator.CurrentUserName, Session.SecureSessionId)
		        App.DataSvc.UserLoggedOn(Session.Authenticator.CurrentUserName)
		        If Session.CurrentAction <> "" Then
		          GoToURL("#" + Session.CurrentAction)
		        Else
		          GoToURL("#station")
		        End
		      Else
		        ShowHint("Die Anmeldung hat leider nicht geklappt. Bitte prüfen Sie Ihren Benutzernamen und Ihr Passwort.")
		        FailedLogonCount = FailedLogonCount + 1
		        Log.Warning("User logon failed: invalid user/password (FailedLogonCount=" + Str(FailedLogonCount) + ", User=" + tbUserName.Text + ").", Session.SecureSessionId)
		      End
		      
		    End
		    
		  Catch e As RuntimeException
		    ShowHint("Es ist ein Fehler aufgetreten. Die Anmeldung hat leider nicht geklappt. Bitte versuchen Sie es später noch einmal.")
		    FailedLogonCount = FailedLogonCount + 1
		    Log.Error("User logon failed: " + e.Message + String.FromArray(e.Stack, "; "), Session.SecureSessionId)
		    
		  End
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events lbHint
	#tag Event
		Sub Opening()
		  me.text = ""
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnNewPwd
	#tag Event
		Sub Pressed()
		  If tbUserName.Text.Length > 1 Then
		    DialogYesNo1.Show("Möchten Sie Ihr Passwort zurücksetzen? Sie erhalten eine E-Mail mit einem Link und können anschließend ein neues Passwort setzen.")
		  Else
		    MessageBox("Bitte geben Sie Ihren Benutzernamen an, um ein neues Passwort anzufordern.")
		  End
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DialogYesNo1
	#tag Event
		Sub YesClicked(tag as Variant)
		  App.DataSvc.UserRequestPasswordReset(tbUserName.Text)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="RequiresAuthenticatedUser"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="PanelIndex"
		Visible=false
		Group="Behavior"
		InitialValue=""
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
		Name="_mPanelIndex"
		Visible=false
		Group="Behavior"
		InitialValue="-1"
		Type="Integer"
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
		Visible=false
		Group="Behavior"
		InitialValue=""
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
		Name="MinimumHeight"
		Visible=true
		Group="Behavior"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Behavior"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Behavior"
		InitialValue="Untitled"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=false
		Group="Behavior"
		InitialValue="True"
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
		Name="_ImplicitInstance"
		Visible=false
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
		Name="IsImplicitInstance"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowTabOrderWrap"
		Visible=false
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
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
	#tag ViewProperty
		Name="ScaleFactor"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Double"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
