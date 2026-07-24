#tag WebContainerControl
Begin WebContainer SelectableStationListContainer
   Compatibility   =   ""
   ControlCount    =   0
   ControlID       =   ""
   CSSClasses      =   ""
   Enabled         =   True
   Height          =   340
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
   Width           =   280
   _mDesignHeight  =   0
   _mDesignWidth   =   0
   _mPanelIndex    =   -1
   Begin WebListBox ListBox1
      AllowRowReordering=   False
      ColumnCount     =   2
      ColumnWidths    =   "60, *"
      ControlID       =   ""
      CSSClasses      =   ""
      DefaultRowHeight=   30
      Enabled         =   True
      GridLineStyle   =   0
      HasBorder       =   False
      HasHeader       =   False
      HeaderHeight    =   0
      Height          =   290
      HighlightSortedColumn=   True
      Index           =   -2147483648
      Indicator       =   0
      InitialValue    =   ""
      LastAddedRowIndex=   0
      LastColumnIndex =   0
      LastRowIndex    =   0
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      NoRowsMessage   =   ""
      PanelIndex      =   0
      ProcessingMessage=   ""
      RowCount        =   0
      RowSelectionType=   0
      Scope           =   2
      SearchCriteria  =   ""
      SelectedRowColor=   &c0d6efd
      SelectedRowIndex=   0
      TabIndex        =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Visible         =   True
      Width           =   280
      _mPanelIndex    =   -1
   End
   Begin WebButton bntOk
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "OK"
      ControlID       =   ""
      CSSClasses      =   ""
      Default         =   False
      Enabled         =   True
      Height          =   30
      Index           =   -2147483648
      Indicator       =   0
      Left            =   10
      LockBottom      =   True
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      LockVertical    =   False
      Outlined        =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   1
      TabStop         =   True
      Tooltip         =   ""
      Top             =   300
      Visible         =   True
      Width           =   80
      _mPanelIndex    =   -1
   End
   Begin WebButton bntToggleCheck
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   ""
      ControlID       =   ""
      CSSClasses      =   "bi bi-toggles no-border"
      Default         =   False
      Enabled         =   True
      Height          =   30
      Index           =   -2147483648
      Indicator       =   7
      Left            =   226
      LockBottom      =   True
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      LockVertical    =   False
      Outlined        =   True
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   2
      TabStop         =   True
      Tooltip         =   ""
      Top             =   300
      Visible         =   True
      Width           =   44
      _mPanelIndex    =   -1
   End
End
#tag EndWebContainerControl

#tag WindowCode
	#tag Method, Flags = &h21
		Private Sub Constructor()
		  // Calling the overridden superclass constructor.
		  // Note that this may need modifications if there are multiple constructor choices.
		  // Possible constructor calls:
		  // Constructor() -- From WebView
		  // Constructor() -- From WebUIControl
		  // Constructor() -- From WebControl
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(selectedStationUids() as String)
		  System.DebugLog(CurrentMethodName)
		  
		  Self.MySelectedStationUids = selectedStationUids
		  
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PopulateList()
		  ListBox1.RemoveAllRows
		  ListBox1.ColumnTypeAt(0) = WebListBox.CellTypes.CheckBox
		  
		  For Each station As StationModel In App.DataSvc.Stations
		    ListBox1.AddRow("", station.ShortName)
		    ListBox1.RowTagAt(ListBox1.LastAddedRowIndex) = station
		    If Self.MySelectedStationUids.IndexOf(station.Uid) >= 0 Then
		      ListBox1.CellCheckBoxValueAt(ListBox1.LastAddedRowIndex, 0) = true
		    end
		  Next
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event OkPressed(selectedStationsUid() as String)
	#tag EndHook


	#tag Property, Flags = &h21
		Private MySelectedStationUids() As String
	#tag EndProperty


#tag EndWindowCode

#tag Events ListBox1
	#tag Event
		Sub Pressed(row As Integer, column As Integer)
		  //Me.CellCheckBoxValueAt(row, 0) = Not Me.CellCheckBoxValueAt(row, 0)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Shown()
		  Self.PopulateList
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events bntOk
	#tag Event
		Sub Pressed()
		  MySelectedStationUids.RemoveAll
		  For i As Integer = 0 To ListBox1.RowCount - 1
		    If ListBox1.CellCheckBoxValueAt(i, 0) Then
		      Var station As StationModel = ListBox1.RowTagAt(i)
		      MySelectedStationUids.Add(station.Uid)
		    end
		  Next
		  
		  Self.Close
		  RaiseEvent OkPressed(MySelectedStationUids)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events bntToggleCheck
	#tag Event
		Sub Pressed()
		  var b as Boolean = ListBox1.CellCheckBoxValueAt(0, 0)
		  For i As Integer = 0 To ListBox1.RowCount - 1
		    ListBox1.CellCheckBoxValueAt(i, 0) = not b
		  Next
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
