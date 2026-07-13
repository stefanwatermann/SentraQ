#tag WebContainerControl
Begin WebContainer ComponentActorViewContainer Implements IEmbeddableViewContainer
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
   Width           =   180
   _mDesignHeight  =   0
   _mDesignWidth   =   0
   _mPanelIndex    =   -1
   Begin WebLabel lbDisplayName
      BindProperty    =   "DisplayName"
      Bold            =   False
      ControlID       =   ""
      CSSClasses      =   "component-title"
      Enabled         =   True
      FontName        =   ""
      FontSize        =   14.0
      Height          =   20
      HTMLElement     =   0
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
      Text            =   "..."
      TextAlignment   =   0
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   15
      Underline       =   False
      Visible         =   True
      Width           =   120
      _mPanelIndex    =   -1
   End
   Begin WebButton btnInfo
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   ""
      ControlID       =   ""
      CSSClasses      =   "border-0 bi bi-info-circle text-secondary"
      Default         =   False
      Enabled         =   True
      Height          =   30
      Index           =   -2147483648
      Indicator       =   7
      Left            =   145
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
      Visible         =   True
      Width           =   30
      _mPanelIndex    =   -1
   End
   Begin WebLabel lbSwitchValue
      Bold            =   False
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   0.0
      Height          =   35
      HTMLElement     =   0
      Index           =   -2147483648
      Indicator       =   ""
      Italic          =   False
      Left            =   80
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
      TabIndex        =   4
      TabStop         =   True
      Text            =   "--"
      TextAlignment   =   0
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   50
      Underline       =   False
      Visible         =   True
      Width           =   80
      _mPanelIndex    =   -1
   End
   Begin WebSwitch Switch1
      Caption         =   ""
      ControlCount    =   "0"
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   False
      Height          =   35
      Indeterminate   =   False
      Index           =   -2147483648
      Indicator       =   0
      LayoutDirection =   "0"
      LayoutType      =   "0"
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      PanelIndex      =   0
      Scope           =   2
      ScrollDirection =   "0"
      TabIndex        =   5
      TabStop         =   True
      Tooltip         =   ""
      Top             =   50
      Value           =   False
      Visible         =   True
      Width           =   50
      _mDesignHeight  =   "0"
      _mDesignWidth   =   "0"
      _mPanelIndex    =   -1
   End
   Begin WebLabel lbWaitForResponse
      Bold            =   False
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   11.0
      Height          =   15
      HTMLElement     =   0
      Index           =   -2147483648
      Indicator       =   ""
      Italic          =   False
      Left            =   23
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   6
      TabStop         =   True
      Text            =   "Warte auf Komponente..."
      TextAlignment   =   0
      TextColor       =   &c79797900
      Tooltip         =   ""
      Top             =   86
      Underline       =   False
      Visible         =   False
      Width           =   150
      _mPanelIndex    =   -1
   End
End
#tag EndWebContainerControl

#tag WindowCode
	#tag Method, Flags = &h0
		Sub Constructor(component as ComponentModel)
		  Self.MyComponent = component
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetParam() As Variant
		  // Part of the IEmbeddableViewContainer interface.
		  return Self.MyComponent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetSwitchLabel(v as boolean)
		  lbSwitchValue.Text = If (v, "An", "Aus")
		  lbSwitchValue.TextColor = If (v, &c4FA90000, &c42424200)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ToggleValue(value as Boolean)
		  If Not Switch1.Indeterminate = True Then
		    
		    If Not WasBackendChange Then
		      
		      // Switch in den Wartezustand versetzen, um auf Bestätigung des zu Warten
		      Switch1.Enabled = False
		      lbWaitForResponse.Visible = True
		      MyComponent.CurrentValue = If(value, 1, 0)
		      LastChangedByUser = DateTime.Now
		      
		      // Wert senden
		      App.DataSvc.SetComponentValue(MyComponent.HardwareId, if(value, "1", "0"), Session.CurrentUser.Login)
		      
		    End
		    
		  end
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateControls()
		  Try 
		    
		    lbDisplayName.Text = MyComponent.ShortName
		    
		    // Da der ValueChanged Event des WebSwitch nicht zwischen 
		    // User-Click und ändern des Value durch Code unterschiedet,
		    // muss hier die Hilfsvariable WasBackendChange helfen. 
		    Self.WasBackendChange = True
		    
		    If LastChangedByUser <> Nil And Self.MyComponent.LastReceivedTs > LastChangedByUser Then
		      LastChangedByUser = Nil
		    End
		    
		    if LastChangedByUser = nil then 
		      Var v As Boolean = If (Self.MyComponent.CurrentValue.IntegerValue = 0, False, True)
		      SetSwitchLabel(v)
		      Switch1.Value = v
		      lbWaitForResponse.Visible = false
		      Switch1.Enabled = Session.WasPasskeyAuthentication And Not MyStation.MaintenanceActive And MyComponent.TypeDef = Enums.ComponentTypes.Switch
		    end
		    
		  Finally
		    // nur Finally erforderlich, um die Hilfsvariable immer zurück zu setzen
		    Self.WasBackendChange = False
		    
		  end
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private LastChangedByUser As DateTime
	#tag EndProperty

	#tag Property, Flags = &h21
		Private MyComponent As ComponentModel
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  if MyComponent <> nil then
			    Return App.DataSvc.GetCachedStationByUid(MyComponent.StationUid)
			  Else
			    Return Nil
			  end
			End Get
		#tag EndGetter
		Private MyStation As StationModel
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private WasBackendChange As Boolean = False
	#tag EndProperty


#tag EndWindowCode

#tag Events btnInfo
	#tag Event
		Sub Pressed()
		  Var container As New ComponentInfoChartContainer
		  container.Render(MyComponent)
		  container.ShowPopover(Me)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Switch1
	#tag Event
		Sub Shown()
		  Me.Enabled = Session.WasPasskeyAuthentication And Not MyStation.MaintenanceActive And MyComponent.TypeDef = Enums.ComponentTypes.Switch
		End Sub
	#tag EndEvent
	#tag Event
		Sub ValueChanged()
		  ToggleValue(me.Value)
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
