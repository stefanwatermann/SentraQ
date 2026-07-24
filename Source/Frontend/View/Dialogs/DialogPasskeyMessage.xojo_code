#tag WebPage
Begin WebDialog DialogPasskeyMessage
   Compatibility   =   ""
   ControlCount    =   0
   ControlID       =   ""
   CSSClasses      =   ""
   Enabled         =   True
   Height          =   340
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
   Width           =   600
   _mDesignHeight  =   0
   _mDesignWidth   =   0
   _mPanelIndex    =   -1
   Begin WebLabel Label1
      Bold            =   False
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   0.0
      Height          =   38
      HTMLElement     =   4
      Index           =   -2147483648
      Indicator       =   0
      Italic          =   False
      Left            =   50
      LockBottom      =   False
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   0
      TabStop         =   True
      Text            =   "Anmeldung mit persönlichem Passkey"
      TextAlignment   =   0
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   30
      Underline       =   False
      Visible         =   True
      Width           =   450
      _mPanelIndex    =   -1
   End
   Begin WebLabel lbMessage
      Bold            =   False
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   0.0
      Height          =   100
      HTMLElement     =   0
      Index           =   -2147483648
      Indicator       =   0
      Italic          =   False
      Left            =   50
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
      TabIndex        =   1
      TabStop         =   True
      Text            =   "..."
      TextAlignment   =   0
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   85
      Underline       =   False
      Visible         =   True
      Width           =   500
      _mPanelIndex    =   -1
   End
   Begin WebButton btnNewPasskey
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "Neuen Passkey erstellen"
      ControlID       =   ""
      CSSClasses      =   ""
      Default         =   False
      Enabled         =   True
      Height          =   38
      Index           =   -2147483648
      Indicator       =   0
      Left            =   300
      LockBottom      =   False
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Outlined        =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   2
      TabStop         =   True
      Tooltip         =   ""
      Top             =   260
      Visible         =   True
      Width           =   250
      _mPanelIndex    =   -1
   End
   Begin WebButton btnClose
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "Schließen"
      ControlID       =   ""
      CSSClasses      =   ""
      Default         =   False
      Enabled         =   True
      Height          =   38
      Index           =   -2147483648
      Indicator       =   0
      Left            =   50
      LockBottom      =   False
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Outlined        =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   3
      TabStop         =   True
      Tooltip         =   ""
      Top             =   260
      Visible         =   True
      Width           =   130
      _mPanelIndex    =   -1
   End
   Begin WebLabel Label2
      Bold            =   False
      ControlID       =   ""
      CSSClasses      =   "xsmall"
      Enabled         =   True
      FontName        =   ""
      FontSize        =   0.0
      Height          =   50
      HTMLElement     =   0
      Index           =   -2147483648
      Indicator       =   0
      Italic          =   False
      Left            =   50
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   True
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   4
      TabStop         =   True
      Text            =   "Klicken Sie ""Neuen Passkey erstellen"", falls Sie für diese Anwendung noch keinen Passkey besitzen."
      TextAlignment   =   0
      TextColor       =   &c5E5E5E00
      Tooltip         =   ""
      Top             =   195
      Underline       =   False
      Visible         =   True
      Width           =   500
      _mPanelIndex    =   -1
   End
End
#tag EndWebPage

#tag WindowCode
	#tag Method, Flags = &h0
		Sub Show(passkeyMessage as string)
		  Self.PasskeyMessage = passkeyMessage
		  
		  self.lbMessage.Text = Self.GetPasskeyMessage
		  
		  // Calling the overridden superclass method.
		  Super.Show()
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event CreatePasskeyPressed()
	#tag EndHook


	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Var s As String = Self.PasskeyMessage.Lowercase
			  
			  If s.Contains("requested RPID did not match the origin") Then
			    return "Es ist kein Passkey für diese Anwendung vorhanden (requested RPID did not match the origin). Bitte klicken Sie 'Neuen Passkey erstellen'."
			    
			  ElseIf s.Contains("request is not allowed by the user agent") Then
			    return "Die Anmeldung wurde abgebrochen."
			    
			  ElseIf s.Contains("credential id mismatch") Then
			    return "Der gewählte Passkey kann nicht für diese Anwendung verwendet werden (credential id mismatch). Bitte wählen Sie einen anderen Passkey oder erstellen Sie einen neuen."
			    
			  ElseIf s = "webauthn not supported" Then
			    return "FEHLER: Passkey Anmeldung nicht unterstützt (webauthn not supported). Bitte prüfen Sie, ob die Seite per 'https://' aufgerufen wurde."
			    
			  Else
			    return s
			    
			  End
			End Get
		#tag EndGetter
		Private GetPasskeyMessage As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private PasskeyMessage As String
	#tag EndProperty


#tag EndWindowCode

#tag Events btnNewPasskey
	#tag Event
		Sub Pressed()
		  Self.Close
		  RaiseEvent CreatePasskeyPressed
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnClose
	#tag Event
		Sub Pressed()
		  self.Close
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
