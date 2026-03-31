#tag WebContainerControl
Begin ModelBinding.BindableWebContainer AdminComponentsEditContainer
   Compatibility   =   ""
   ControlCount    =   0
   ControlID       =   ""
   CSSClasses      =   ""
   Enabled         =   True
   Height          =   388
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
   Width           =   630
   _mDesignHeight  =   0
   _mDesignWidth   =   0
   _mPanelIndex    =   -1
   Begin WebLabel Label1
      Bold            =   False
      ControlID       =   ""
      CSSClasses      =   "small"
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
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   0
      TabStop         =   True
      Text            =   "Anzeigename"
      TextAlignment   =   0
      TextColor       =   &c79797900
      Tooltip         =   ""
      Top             =   0
      Underline       =   False
      Visible         =   True
      Width           =   360
      _mPanelIndex    =   -1
   End
   Begin ModelBinding.BindableWebTextField tbDisplayName
      AllowAutoComplete=   True
      AllowSpellChecking=   True
      BindProperty    =   "DisplayName"
      Caption         =   ""
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FieldType       =   0
      Height          =   38
      Hint            =   ""
      Index           =   -2147483648
      Indicator       =   0
      IsValid         =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      MaximumCharactersAllowed=   250
      PanelIndex      =   0
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   1
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      Tooltip         =   ""
      Top             =   30
      Visible         =   True
      Width           =   590
      _mPanelIndex    =   -1
   End
   Begin WebLabel Label2
      Bold            =   False
      ControlID       =   ""
      CSSClasses      =   "small"
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
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   2
      TabStop         =   True
      Text            =   "Kurzname"
      TextAlignment   =   0
      TextColor       =   &c79797900
      Tooltip         =   ""
      Top             =   76
      Underline       =   False
      Visible         =   True
      Width           =   360
      _mPanelIndex    =   -1
   End
   Begin ModelBinding.BindableWebTextField tbShortName
      AllowAutoComplete=   True
      AllowSpellChecking=   True
      BindProperty    =   "ShortName"
      Caption         =   ""
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FieldType       =   0
      Height          =   38
      Hint            =   ""
      Index           =   -2147483648
      Indicator       =   0
      IsValid         =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      MaximumCharactersAllowed=   50
      PanelIndex      =   0
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   3
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      Tooltip         =   ""
      Top             =   105
      Visible         =   True
      Width           =   360
      _mPanelIndex    =   -1
   End
   Begin WebLabel Label4
      Bold            =   False
      ControlID       =   ""
      CSSClasses      =   "small"
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
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   6
      TabStop         =   True
      Text            =   "Komponententyp"
      TextAlignment   =   0
      TextColor       =   &c79797900
      Tooltip         =   ""
      Top             =   150
      Underline       =   False
      Visible         =   True
      Width           =   200
      _mPanelIndex    =   -1
   End
   Begin ModelBinding.BindableWebPopupMenu cbType
      BindProperty    =   "Type"
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      Height          =   38
      Index           =   -2147483648
      Indicator       =   0
      InitialValue    =   ""
      LastAddedRowIndex=   0
      LastRowIndex    =   0
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      PanelIndex      =   0
      RowCount        =   0
      Scope           =   2
      SelectedRowIndex=   0
      SelectedRowText =   ""
      TabIndex        =   7
      TabStop         =   True
      Tooltip         =   ""
      Top             =   180
      Visible         =   True
      Width           =   360
      _mPanelIndex    =   -1
   End
   Begin ModelBinding.BindableWebLabel lbHardwareId
      BindProperty    =   "HardwareId"
      Bold            =   False
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   0.0
      Height          =   38
      Index           =   -2147483648
      Indicator       =   0
      Italic          =   False
      Left            =   425
      LockBottom      =   False
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   11
      TabStop         =   True
      Text            =   "---"
      TextAlignment   =   0
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   105
      Underline       =   False
      Visible         =   True
      Width           =   185
      _mPanelIndex    =   -1
   End
   Begin WebLabel Label6
      Bold            =   False
      ControlID       =   ""
      CSSClasses      =   "small"
      Enabled         =   True
      FontName        =   ""
      FontSize        =   0.0
      Height          =   30
      Index           =   -2147483648
      Indicator       =   0
      Italic          =   False
      Left            =   425
      LockBottom      =   False
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   12
      TabStop         =   True
      Text            =   "HardwareID"
      TextAlignment   =   0
      TextColor       =   &c79797900
      Tooltip         =   ""
      Top             =   76
      Underline       =   False
      Visible         =   True
      Width           =   185
      _mPanelIndex    =   -1
   End
   Begin WebLabel Label7
      Bold            =   False
      ControlID       =   ""
      CSSClasses      =   "small"
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
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   13
      TabStop         =   True
      Text            =   "Minimum Wert"
      TextAlignment   =   0
      TextColor       =   &c79797900
      Tooltip         =   ""
      Top             =   225
      Underline       =   False
      Visible         =   True
      Width           =   160
      _mPanelIndex    =   -1
   End
   Begin WebLabel Label8
      Bold            =   False
      ControlID       =   ""
      CSSClasses      =   "small"
      Enabled         =   True
      FontName        =   ""
      FontSize        =   0.0
      Height          =   30
      Index           =   -2147483648
      Indicator       =   0
      Italic          =   False
      Left            =   210
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
      TabIndex        =   14
      TabStop         =   True
      Text            =   "Maximum Wert"
      TextAlignment   =   0
      TextColor       =   &c79797900
      Tooltip         =   ""
      Top             =   225
      Underline       =   False
      Visible         =   True
      Width           =   160
      _mPanelIndex    =   -1
   End
   Begin ModelBinding.BindableWebTextField tbMinValue
      AllowAutoComplete=   False
      AllowSpellChecking=   False
      BindProperty    =   "MinValue"
      Caption         =   ""
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FieldType       =   3
      Height          =   38
      Hint            =   ""
      Index           =   -2147483648
      Indicator       =   0
      IsValid         =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      MaximumCharactersAllowed=   20
      PanelIndex      =   0
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   15
      TabStop         =   True
      Text            =   "0"
      TextAlignment   =   0
      Tooltip         =   ""
      Top             =   255
      Visible         =   True
      Width           =   160
      _mPanelIndex    =   -1
   End
   Begin ModelBinding.BindableWebTextField tbMaxValue
      AllowAutoComplete=   False
      AllowSpellChecking=   False
      BindProperty    =   "MaxValue"
      Caption         =   ""
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FieldType       =   3
      Height          =   38
      Hint            =   ""
      Index           =   -2147483648
      Indicator       =   0
      IsValid         =   False
      Left            =   210
      LockBottom      =   False
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      MaximumCharactersAllowed=   20
      PanelIndex      =   0
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   16
      TabStop         =   True
      Text            =   "1"
      TextAlignment   =   0
      Tooltip         =   ""
      Top             =   255
      Visible         =   True
      Width           =   160
      _mPanelIndex    =   -1
   End
   Begin WebLabel Label9
      Bold            =   False
      ControlID       =   ""
      CSSClasses      =   "small"
      Enabled         =   True
      FontName        =   ""
      FontSize        =   0.0
      Height          =   30
      Index           =   -2147483648
      Indicator       =   0
      Italic          =   False
      Left            =   400
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
      TabIndex        =   17
      TabStop         =   True
      Text            =   "Anzeige-Reihenfolge"
      TextAlignment   =   0
      TextColor       =   &c79797900
      Tooltip         =   ""
      Top             =   300
      Underline       =   False
      Visible         =   True
      Width           =   200
      _mPanelIndex    =   -1
   End
   Begin ModelBinding.BindableWebTextField tbDisplayOrder
      AllowAutoComplete=   False
      AllowSpellChecking=   False
      BindProperty    =   "DisplayOrder"
      Caption         =   ""
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FieldType       =   3
      Height          =   38
      Hint            =   ""
      Index           =   -2147483648
      Indicator       =   0
      IsValid         =   False
      Left            =   400
      LockBottom      =   False
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      MaximumCharactersAllowed=   0
      PanelIndex      =   0
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   18
      TabStop         =   True
      Text            =   "0"
      TextAlignment   =   0
      Tooltip         =   ""
      Top             =   330
      Visible         =   True
      Width           =   90
      _mPanelIndex    =   -1
   End
   Begin WebLabel Label11
      Bold            =   False
      ControlID       =   ""
      CSSClasses      =   "small"
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
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   21
      TabStop         =   True
      Text            =   "Adjustierungsfunktion (+-*/Zahl)"
      TextAlignment   =   0
      TextColor       =   &c79797900
      Tooltip         =   ""
      Top             =   300
      Underline       =   False
      Visible         =   True
      Width           =   350
      _mPanelIndex    =   -1
   End
   Begin ModelBinding.BindableWebTextField tbAdjustmentFunction
      AllowAutoComplete=   False
      AllowSpellChecking=   False
      BindProperty    =   "AdjustmentFunction"
      Caption         =   ""
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FieldType       =   0
      Height          =   38
      Hint            =   ""
      Index           =   -2147483648
      Indicator       =   0
      IsValid         =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      MaximumCharactersAllowed=   10
      PanelIndex      =   0
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   22
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      Tooltip         =   ""
      Top             =   330
      Visible         =   True
      Width           =   350
      _mPanelIndex    =   -1
   End
   Begin WebLabel Label10
      Bold            =   False
      ControlID       =   ""
      CSSClasses      =   "small"
      Enabled         =   True
      FontName        =   ""
      FontSize        =   0.0
      Height          =   30
      Index           =   -2147483648
      Indicator       =   0
      Italic          =   False
      Left            =   400
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
      TabIndex        =   23
      TabStop         =   True
      Text            =   "Anzeige-Einheit"
      TextAlignment   =   0
      TextColor       =   &c79797900
      Tooltip         =   ""
      Top             =   225
      Underline       =   False
      Visible         =   True
      Width           =   140
      _mPanelIndex    =   -1
   End
   Begin ModelBinding.BindableWebTextField tbDisplayUnit
      AllowAutoComplete=   False
      AllowSpellChecking=   False
      BindProperty    =   "DisplayUnit"
      Caption         =   ""
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FieldType       =   3
      Height          =   38
      Hint            =   ""
      Index           =   -2147483648
      Indicator       =   0
      IsValid         =   False
      Left            =   400
      LockBottom      =   False
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      MaximumCharactersAllowed=   0
      PanelIndex      =   0
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   24
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      Tooltip         =   ""
      Top             =   255
      Visible         =   True
      Width           =   140
      _mPanelIndex    =   -1
   End
End
#tag EndWebContainerControl

#tag WindowCode
	#tag Event
		Sub Shown()
		  System.DebugLog(CurrentMethodName)
		  If cbType.HasTag(Self.MyComponent.Type) Then
		    cbType.SelectRowWithTag(Self.MyComponent.Type)
		  Else
		    cbType.SelectedRowIndex = 0
		  End
		End Sub
	#tag EndEvent


	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  System.DebugLog(CurrentMethodName)
			  Return ComponentModel(Self.Model)
			End Get
		#tag EndGetter
		Private MyComponent As ComponentModel
	#tag EndComputedProperty


#tag EndWindowCode

#tag Events tbDisplayName
	#tag Event
		Function Validate() As Boolean
		  Return Me.Text.Length > 3
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events tbShortName
	#tag Event
		Function Validate() As Boolean
		  Return Me.Text.Length >= 2
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events cbType
	#tag Event
		Sub Opening()
		  Me.RemoveAllRows
		  Me.AddRow("Aktor", "AC")
		  Me.AddRow("Füllstand", "FI")
		  Me.AddRow("Störung", "FL")
		  Me.AddRow("Sensor", "SE")
		  Me.AddRow("Zähler", "CO")
		  Me.AddRow("Visueller Trenner", "DI")
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged(item as WebMenuItem)
		  self.UpdateBindValue(me.BindProperty, item.Tag)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events tbMinValue
	#tag Event
		Function Validate() As Boolean
		  Return Me.Text.Length >= 2
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events tbMaxValue
	#tag Event
		Function Validate() As Boolean
		  Return Me.Text.Length >= 2
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events tbDisplayOrder
	#tag Event
		Function Validate() As Boolean
		  Return true
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events tbAdjustmentFunction
	#tag Event
		Function Validate() As Boolean
		  Return me.text.Length = 0 or (me.text.Length > 1 and (me.text.BeginsWith("+") or me.text.BeginsWith("-") or me.text.BeginsWith("*") or me.text.BeginsWith("/")))
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events tbDisplayUnit
	#tag Event
		Function Validate() As Boolean
		  Return true
		End Function
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
		Name="ShowDebugLog"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
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
