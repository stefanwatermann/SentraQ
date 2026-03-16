#tag WebContainerControl
Begin ModelBinding.BindableWebContainer AdminStationsEditContainer
   Compatibility   =   ""
   ControlCount    =   0
   ControlID       =   ""
   CSSClasses      =   ""
   Enabled         =   True
   Height          =   460
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
   Width           =   800
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
      AllowAutoComplete=   False
      AllowSpellChecking=   False
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
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      MaximumCharactersAllowed=   0
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
      Width           =   530
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
      AllowAutoComplete=   False
      AllowSpellChecking=   False
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
      TextAlignment   =   0
      Tooltip         =   ""
      Top             =   106
      Visible         =   True
      Width           =   530
      _mPanelIndex    =   -1
   End
   Begin WebLabel Label3
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
      TabIndex        =   4
      TabStop         =   True
      Text            =   "Alarm E-Mail Empfänger"
      TextAlignment   =   0
      TextColor       =   &c79797900
      Tooltip         =   ""
      Top             =   152
      Underline       =   False
      Visible         =   True
      Width           =   360
      _mPanelIndex    =   -1
   End
   Begin ModelBinding.BindableWebTextField tbAlertEmailRecipients
      AllowAutoComplete=   False
      AllowSpellChecking=   False
      BindProperty    =   "AlertReceiverEmailAddresses"
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
      MaximumCharactersAllowed=   0
      PanelIndex      =   0
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   5
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      Tooltip         =   ""
      Top             =   182
      Visible         =   True
      Width           =   760
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
      Text            =   "Stationstyp"
      TextAlignment   =   0
      TextColor       =   &c79797900
      Tooltip         =   ""
      Top             =   228
      Underline       =   False
      Visible         =   True
      Width           =   200
      _mPanelIndex    =   -1
   End
   Begin ModelBinding.BindableWebPopupMenu cbStationType
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
      Top             =   258
      Visible         =   True
      Width           =   200
      _mPanelIndex    =   -1
   End
   Begin WebButton btnSave
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "Speichern"
      ControlID       =   ""
      CSSClasses      =   ""
      Default         =   False
      Enabled         =   False
      Height          =   38
      Index           =   -2147483648
      Indicator       =   0
      Left            =   20
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
      TabIndex        =   8
      TabStop         =   True
      Tooltip         =   ""
      Top             =   410
      Visible         =   True
      Width           =   140
      _mPanelIndex    =   -1
   End
   Begin WebLabel lbHint
      Bold            =   False
      ControlID       =   ""
      CSSClasses      =   "small"
      Enabled         =   True
      FontName        =   ""
      FontSize        =   0.0
      Height          =   38
      Index           =   -2147483648
      Indicator       =   0
      Italic          =   False
      Left            =   190
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
      TabIndex        =   9
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &cDB210100
      Tooltip         =   ""
      Top             =   410
      Underline       =   False
      Visible         =   True
      Width           =   590
      _mPanelIndex    =   -1
   End
   Begin DialogInfoMessage DialogInfoMessage1
      ControlCount    =   0
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      Height          =   230
      Index           =   -2147483648
      Indicator       =   0
      LayoutDirection =   0
      LayoutType      =   0
      Left            =   200
      LockBottom      =   False
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   False
      LockVertical    =   False
      PanelIndex      =   0
      Position        =   0
      Scope           =   2
      TabIndex        =   10
      TabStop         =   True
      Tooltip         =   ""
      Top             =   50
      Visible         =   True
      Width           =   400
      _mDesignHeight  =   0
      _mDesignWidth   =   0
      _mPanelIndex    =   -1
   End
   Begin ModelBinding.BindableWebLabel lbUid
      BindProperty    =   "Uid"
      Bold            =   False
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   0.0
      Height          =   38
      Index           =   -2147483648
      Indicator       =   ""
      Italic          =   False
      Left            =   595
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
      TabIndex        =   11
      TabStop         =   True
      Text            =   "---"
      TextAlignment   =   0
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   30
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
      Left            =   595
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
      TabIndex        =   12
      TabStop         =   True
      Text            =   "UID"
      TextAlignment   =   0
      TextColor       =   &c79797900
      Tooltip         =   ""
      Top             =   0
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
      Left            =   260
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
      Text            =   "Position Breite (Latitude)"
      TextAlignment   =   0
      TextColor       =   &c79797900
      Tooltip         =   ""
      Top             =   228
      Underline       =   False
      Visible         =   True
      Width           =   200
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
      Left            =   495
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
      Text            =   "Position Länge (Longitude)"
      TextAlignment   =   0
      TextColor       =   &c79797900
      Tooltip         =   ""
      Top             =   228
      Underline       =   False
      Visible         =   True
      Width           =   200
      _mPanelIndex    =   -1
   End
   Begin ModelBinding.BindableWebTextField tbLatitue Implements ModelBinding.IBindableWebControl
      AllowAutoComplete=   False
      AllowSpellChecking=   False
      BindProperty    =   "Latittude"
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
      Left            =   260
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
      TabIndex        =   15
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      Tooltip         =   ""
      Top             =   258
      Visible         =   True
      Width           =   200
      _mPanelIndex    =   -1
   End
   Begin ModelBinding.BindableWebTextField tbLongitude Implements ModelBinding.IBindableWebControl
      AllowAutoComplete=   False
      AllowSpellChecking=   False
      BindProperty    =   "Longitude"
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
      Left            =   495
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
      TabIndex        =   16
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      Tooltip         =   ""
      Top             =   258
      Visible         =   True
      Width           =   200
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
      Left            =   495
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
      Top             =   310
      Underline       =   False
      Visible         =   True
      Width           =   200
      _mPanelIndex    =   -1
   End
   Begin ModelBinding.BindableWebTextField tbDisplayOrder Implements ModelBinding.IBindableWebControl
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
      Left            =   495
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
      Text            =   ""
      TextAlignment   =   0
      Tooltip         =   ""
      Top             =   340
      Visible         =   True
      Width           =   90
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
      TabIndex        =   19
      TabStop         =   True
      Text            =   "Watchdog HardwareId"
      TextAlignment   =   0
      TextColor       =   &c79797900
      Tooltip         =   ""
      Top             =   310
      Underline       =   False
      Visible         =   True
      Width           =   200
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
      Left            =   260
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
      Text            =   "Farbe"
      TextAlignment   =   0
      TextColor       =   &c79797900
      Tooltip         =   ""
      Top             =   310
      Underline       =   False
      Visible         =   True
      Width           =   115
      _mPanelIndex    =   -1
   End
   Begin ModelBinding.BindableWebTextField tbDisplayColor Implements ModelBinding.IBindableWebControl
      AllowAutoComplete=   False
      AllowSpellChecking=   False
      BindProperty    =   "DisplayColor"
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
      Left            =   260
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
      TabIndex        =   22
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      Tooltip         =   ""
      Top             =   340
      Visible         =   True
      Width           =   200
      _mPanelIndex    =   -1
   End
   Begin ModelBinding.BindableWebPopupMenu cbWatchdogId
      BindProperty    =   "WatchdogHardwareId"
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
      TabIndex        =   23
      TabStop         =   True
      Tooltip         =   ""
      Top             =   340
      Visible         =   True
      Width           =   200
      _mPanelIndex    =   -1
   End
End
#tag EndWebContainerControl

#tag WindowCode
	#tag Event
		Function Bind() As Object
		  Return Self.MyStation
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub EnableSaveButton()
		  // TODO
		  btnSave.Enabled = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Show(station as StationModel)
		  lbHint.Text = ""
		  
		  Self.MyStation =station
		  Self.BindProperties(Self.MyStation)
		  Self.cbStationType.SelectRowWithTag(Self.MyStation.Type)
		  
		  Self.Visible = True
		  
		  EnableSaveButton
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event StationSaved()
	#tag EndHook


	#tag Property, Flags = &h21
		Private MyStation As StationModel
	#tag EndProperty


#tag EndWindowCode

#tag Events tbDisplayName
	#tag Event
		Sub TextChanged()
		  EnableSaveButton
		End Sub
	#tag EndEvent
	#tag Event
		Function Validate() As Boolean
		  Return Me.Text.Length > 3
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events tbShortName
	#tag Event
		Sub TextChanged()
		  EnableSaveButton
		End Sub
	#tag EndEvent
	#tag Event
		Function Validate() As Boolean
		  Return Me.Text.Length >= 2
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events tbAlertEmailRecipients
	#tag Event
		Sub TextChanged()
		  EnableSaveButton
		End Sub
	#tag EndEvent
	#tag Event
		Function Validate() As Boolean
		  return me.text.Contains("@") and me.Text.Contains(".") and me.Text.Length >= 4
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events cbStationType
	#tag Event
		Sub Opening()
		  Me.RemoveAllRows
		  Me.AddRow("Pumpstation", "PU")
		  Me.AddRow("Abwasserstation", "SE")
		  Me.AddRow("Wasserwerk", "WA")
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged(item as WebMenuItem)
		  self.UpdateBindValue(me.BindProperty, item.Tag)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnSave
	#tag Event
		Sub Pressed()
		  // save user
		  
		  // TODO
		  
		  RaiseEvent StationSaved
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events tbLatitue
	#tag Event
		Sub TextChanged()
		  EnableSaveButton
		End Sub
	#tag EndEvent
	#tag Event
		Function Validate() As Boolean
		  Return Me.Text.Length >= 2
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events tbLongitude
	#tag Event
		Sub TextChanged()
		  EnableSaveButton
		End Sub
	#tag EndEvent
	#tag Event
		Function Validate() As Boolean
		  Return Me.Text.Length >= 2
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events tbDisplayOrder
	#tag Event
		Sub TextChanged()
		  EnableSaveButton
		End Sub
	#tag EndEvent
	#tag Event
		Function Validate() As Boolean
		  Return true
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events tbDisplayColor
	#tag Event
		Sub TextChanged()
		  EnableSaveButton
		End Sub
	#tag EndEvent
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
