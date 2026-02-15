#tag WebContainerControl
Begin WebContainer ComponentMessageViewContainer Implements IEmbeddableViewContainer
   Compatibility   =   ""
   ControlCount    =   0
   ControlID       =   ""
   CSSClasses      =   "component-tile"
   Enabled         =   True
   Height          =   110
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
   Width           =   450
   _mDesignHeight  =   0
   _mDesignWidth   =   0
   _mName          =   ""
   _mPanelIndex    =   -1
   Begin WebLabel lbDisplayName
      BindProperty    =   "DisplayName"
      Bold            =   False
      ControlID       =   ""
      CSSClasses      =   "component-title"
      Enabled         =   True
      FontName        =   ""
      FontSize        =   0.0
      Height          =   30
      Index           =   -2147483648
      Indicator       =   0
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   0
      TabStop         =   True
      Text            =   "Meldungen und Störungen"
      TextAlignment   =   0
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   5
      Underline       =   False
      Visible         =   True
      Width           =   280
      _mPanelIndex    =   -1
   End
   Begin WebLabel lbValue
      Bold            =   False
      ControlID       =   ""
      CSSClasses      =   "component-label-overlay"
      Enabled         =   True
      FontName        =   ""
      FontSize        =   0.0
      Height          =   68
      Index           =   -2147483648
      Indicator       =   0
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   True
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   1
      TabStop         =   True
      Text            =   "..."
      TextAlignment   =   1
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   40
      Underline       =   False
      Visible         =   True
      Width           =   430
      _mPanelIndex    =   -1
   End
   Begin WebButton btnInfo
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "i"
      ControlID       =   ""
      CSSClasses      =   "border-0"
      Default         =   False
      Enabled         =   True
      Height          =   30
      Index           =   -2147483648
      Indicator       =   0
      Left            =   415
      LockBottom      =   False
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      Outlined        =   True
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   2
      TabStop         =   True
      Tooltip         =   ""
      Top             =   5
      Visible         =   False
      Width           =   30
      _mPanelIndex    =   -1
   End
   Begin WebButton btnClear
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "Quittieren..."
      ControlID       =   ""
      CSSClasses      =   ""
      Default         =   False
      Enabled         =   True
      Height          =   30
      Index           =   -2147483648
      Indicator       =   5
      Left            =   300
      LockBottom      =   False
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      Outlined        =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   3
      TabStop         =   True
      Tooltip         =   ""
      Top             =   5
      Visible         =   False
      Width           =   110
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
      Left            =   0
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
      TabIndex        =   4
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Visible         =   True
      Width           =   400
      _mDesignHeight  =   0
      _mDesignWidth   =   0
      _mPanelIndex    =   -1
   End
End
#tag EndWebContainerControl

#tag WindowCode
	#tag Method, Flags = &h0
		Sub Add(component as ComponentModel)
		  Self.Components.Add(component)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ClearAlert()
		  // clear alert on station level
		  App.DataSvc.ClearAlert(Station.Uid, Session.Authenticator.CurrentUserName)
		  App.DataSvc.LoadStations
		  Self.UpdateControls
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.Components.RemoveAll
		  self.Style.Value("width") = "100%"
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetMessage(component as ComponentModel) As string
		  return component.DisplayName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetParam() As Variant
		  // Part of the IEmbeddableViewContainer interface.
		  return self.Components
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateControls()
		  Var messages() As String
		  For Each component As ComponentModel In Self.Components
		    If component.CurrentValue.IntegerValue <> 0 Then
		      messages.Add(GetMessage(component))
		    End
		  Next
		  
		  If messages.Count = 0 Then
		    lbValue.Text = "Keine Störungen."
		    lbValue.TextColor = &c00905100
		  Else
		    lbValue.Text = String.FromArray(messages, EndOfLine)
		    lbValue.TextColor = &cFF260000
		  End
		  
		  // TODO tritt ein Fault auf, so ist zwar die Komponente aktualisiert, aber die Station (noch) nicht
		  //            daher wird der Quittieren Button verzögert angezeigt.
		  btnClear.Visible = If(Station <> Nil, Station.HasActiveAlert, False) And messages.Count <> 0
		  btnClear.Enabled = true
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Components() As ComponentModel
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Var s() As String
			  For Each component As ComponentModel In Self.Components
			    s.Add(component.ShortName + ": " + component.HardwareId)
			  Next
			  If s.Count = 0 Then
			    s.add("Dieser Station sind keine Strörungskomponenten (Typ Fault) zugewiesen.")
			  End
			  Return String.FromArray(s, EndOfLine + "<br/>")
			End Get
		#tag EndGetter
		Private GetInfos As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  If Self.Components.Count > 0 Then
			    Return App.DataSvc.GetStationByUid(Self.Components(0).StationUid)
			  End
			End Get
		#tag EndGetter
		Private Station As StationModel
	#tag EndComputedProperty


	#tag Constant, Name = kComponentInforHtmlTemplate, Type = String, Dynamic = False, Default = \"<raw>\n  <div style\x3D\'margin: 0 20px;\'>\n    <div style\x3D\'font-weight: bold;\'>St\xC3\xB6rung-IDs dieser Station</div>\n    <div style\x3D\'font-size: 0.8em;\'>\n      #data#\n    </div>\n  </div>\n</raw>", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events lbValue
	#tag Event
		Sub Pressed()
		  //MessageBox(lbValue.Text)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnInfo
	#tag Event
		Sub Pressed()
		  // TODO collect infos
		  MessageBox(kComponentInforHtmlTemplate.Replace("#data#", GetInfos))
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnClear
	#tag Event
		Sub Pressed()
		  me.Enabled = false
		  DialogYesNo1.Show("Möchten Sie diese Störung quittieren? Die Störung bleibt bestehen, weitere Alarm Nachrichten werden ausgesetzt.")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DialogYesNo1
	#tag Event
		Sub YesClicked(tag as Variant)
		  ClearAlert()
		End Sub
	#tag EndEvent
	#tag Event
		Sub NoClicked(tag as Variant)
		  btnClear.Enabled = true
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
