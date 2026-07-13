#tag WebPage
Begin LobBase.LobWebPage PageTables
   AllowTabOrderWrap=   True
   Compatibility   =   ""
   ControlCount    =   0
   ControlID       =   ""
   CSSClasses      =   ""
   Enabled         =   False
   Height          =   600
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
   MinimumHeight   =   600
   MinimumWidth    =   800
   PanelIndex      =   0
   RequiresAuthenticatedUser=   True
   ScaleFactor     =   0.0
   TabIndex        =   0
   Title           =   "Tabellen"
   Top             =   0
   Visible         =   True
   Width           =   800
   _ImplicitInstance=   False
   _mDesignHeight  =   0
   _mDesignWidth   =   0
   _mPanelIndex    =   -1
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
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      LockVertical    =   False
      PanelIndex      =   0
      Scope           =   2
      ScrollDirection =   0
      TabIndex        =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   570
      Visible         =   True
      Width           =   800
      _mDesignHeight  =   0
      _mDesignWidth   =   0
      _mPanelIndex    =   -1
   End
   Begin HeaderContainer HeaderContainer1
      ControlCount    =   0
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      Height          =   80
      Index           =   -2147483648
      Indicator       =   0
      LayoutDirection =   0
      LayoutType      =   0
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      PanelIndex      =   0
      Scope           =   2
      ScrollDirection =   0
      TabIndex        =   1
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Visible         =   True
      Width           =   800
      _mDesignHeight  =   0
      _mDesignWidth   =   0
      _mPanelIndex    =   -1
   End
   Begin WebPopupMenu cbTables
      ControlID       =   ""
      CSSClasses      =   "small"
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
      TabIndex        =   2
      TabStop         =   True
      Tooltip         =   ""
      Top             =   100
      Visible         =   True
      Width           =   240
      _mPanelIndex    =   -1
   End
   Begin WebListBox lbData
      AllowRowReordering=   False
      ColumnCount     =   1
      ColumnWidths    =   "*"
      ControlID       =   ""
      CSSClasses      =   "small"
      DefaultRowHeight=   30
      Enabled         =   True
      GridLineStyle   =   2
      HasBorder       =   False
      HasHeader       =   True
      HeaderHeight    =   0
      Height          =   420
      HighlightSortedColumn=   True
      Index           =   -2147483648
      Indicator       =   0
      InitialValue    =   ""
      LastAddedRowIndex=   0
      LastColumnIndex =   0
      LastRowIndex    =   0
      Left            =   5
      LockBottom      =   True
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      NoRowsMessage   =   ""
      PanelIndex      =   0
      ProcessingMessage=   ""
      RowCount        =   0
      RowSelectionType=   1
      Scope           =   2
      SearchCriteria  =   ""
      SelectedRowColor=   &c0096FFAC
      SelectedRowIndex=   0
      TabIndex        =   3
      TabStop         =   True
      Tooltip         =   ""
      Top             =   150
      Visible         =   True
      Width           =   790
      _mPanelIndex    =   -1
   End
   Begin WebSearchField tbSearch
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      Height          =   38
      Hint            =   "Where Bedingung"
      Index           =   -2147483648
      Indicator       =   0
      Left            =   300
      LockBottom      =   False
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   4
      TabStop         =   True
      Text            =   ""
      Tooltip         =   ""
      Top             =   102
      Visible         =   True
      Width           =   210
      _mPanelIndex    =   -1
   End
   Begin WebPopupMenu cbLoadRows
      ControlID       =   ""
      CSSClasses      =   "small"
      Enabled         =   True
      Height          =   38
      Index           =   -2147483648
      Indicator       =   0
      InitialValue    =   "50\n100\n500\n1000"
      LastAddedRowIndex=   0
      LastRowIndex    =   0
      Left            =   700
      LockBottom      =   False
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      PanelIndex      =   0
      RowCount        =   0
      Scope           =   2
      SelectedRowIndex=   0
      SelectedRowText =   ""
      TabIndex        =   5
      TabStop         =   True
      Tooltip         =   ""
      Top             =   100
      Visible         =   True
      Width           =   80
      _mPanelIndex    =   -1
   End
   Begin WebSwitch swOrder
      Caption         =   ""
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      Height          =   35
      Indeterminate   =   False
      Index           =   -2147483648
      Indicator       =   0
      Left            =   540
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   6
      TabStop         =   True
      Tooltip         =   ""
      Top             =   100
      Value           =   False
      Visible         =   True
      Width           =   50
      _mPanelIndex    =   -1
   End
   Begin WaitContainer WaitContainer1
      ControlCount    =   0
      ControlID       =   ""
      CSSClasses      =   "small"
      Enabled         =   True
      Height          =   600
      Index           =   -2147483648
      Indicator       =   0
      LayoutDirection =   0
      LayoutType      =   0
      Left            =   5
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      PanelIndex      =   0
      Scope           =   2
      ScrollDirection =   0
      TabIndex        =   7
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Visible         =   False
      Width           =   800
      _mDesignHeight  =   0
      _mDesignWidth   =   0
      _mPanelIndex    =   -1
   End
   Begin WebLabel Label1
      Bold            =   False
      ControlID       =   ""
      CSSClasses      =   "small"
      Enabled         =   True
      FontName        =   ""
      FontSize        =   0.0
      Height          =   38
      HTMLElement     =   0
      Index           =   -2147483648
      Indicator       =   ""
      Italic          =   False
      Left            =   590
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   8
      TabStop         =   True
      Text            =   "Aufsteigend"
      TextAlignment   =   0
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   100
      Underline       =   False
      Visible         =   True
      Width           =   100
      _mPanelIndex    =   -1
   End
End
#tag EndWebPage

#tag WindowCode
	#tag Event
		Sub Opening()
		  AllTables = kAllTableNames.Split(",")
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown()
		  PopulateTables
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub PopulateData()
		  try
		    Session.ShowWaitIndicator
		    
		    lbData.RemoveAllRows
		    
		    Var rows() As Variant = App.DataSvc.ReadTableData(SelectedTableName, WhereCondition, not swOrder.Value, val(cbLoadRows.SelectedRowText))
		    
		    if rows.Count > 0 Then
		      
		      Var cols() As String = rows(0).StringValue.Split(kFieldSeparator)
		      lbData.ColumnCount = cols.Count
		      For i As integer = 0 To cols.Count - 1
		        lbData.HeaderAt(i) = cols(i)
		      next
		      rows.RemoveAt(0)
		      
		      For Each row As String In rows
		        lbData.AddRow(row.Split(kFieldSeparator))
		      Next
		      
		    End
		  Catch ex As RuntimeException
		    MessageBox(ex.Message)
		    
		  Finally
		    Session.HideWaitIndicator
		    
		  end
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PopulateTables()
		  cbTables.RemoveAllRows
		  
		  For Each table As String In AllTables
		    if table.Trim <> "" then
		      cbTables.AddRow(table.Trim)
		    end
		  Next
		  
		  If LastSelectedTableIndex >= 0 and LastSelectedTableIndex < cbTables.RowCount Then
		    cbTables.SelectedRowIndex = LastSelectedTableIndex
		  end
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private AllTables() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private LastSelectedDataIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private LastSelectedTableIndex As Integer = 0
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  If cbTables.SelectedRowIndex >= 0 Then
			    Return cbTables.SelectedRowText
			  End
			  return ""
			End Get
		#tag EndGetter
		Private SelectedTableName As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  If tbSearch.Text.Trim = "" then
			    Return "WHERE 1=1"
			  else
			    Return "WHERE " + tbSearch.Text.Trim
			  end
			End Get
		#tag EndGetter
		Private WhereCondition As String
	#tag EndComputedProperty


	#tag Constant, Name = kAllTableNames, Type = String, Dynamic = False, Default = \"Alert\x2CvAlert\x2CComponent\x2CCounter\x2CEventData\x2CLog\x2CStation", Scope = Private, Description = 436F6D6D6120736570617261746564206C697374206F66207461626C657320746F2073686F772E205368616C6C204E4F5420696E636C756465207461626C657320636F6E7461696E696E672073656E73697469766520646174612C206C696B652055736572206F722053657474696E672E
	#tag EndConstant

	#tag Constant, Name = kFieldSeparator, Type = String, Dynamic = False, Default = \"~", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events cbTables
	#tag Event
		Sub SelectionChanged(item As WebMenuItem)
		  LastSelectedTableIndex = Me.SelectedRowIndex
		  PopulateData
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events lbData
	#tag Event
		Sub SelectionChanged(rows() As Integer)
		  LastSelectedDataIndex = me.SelectedRowIndex
		End Sub
	#tag EndEvent
	#tag Event
		Sub DoublePressed(row As Integer, column As Integer)
		  Var cellData As String = Me.CellTextAt(row, column)
		  Var colName As String = Me.HeaderAt(column)
		  Var filter As String = """" + colName + """ = '" + cellData + "'"
		  MessageBox(filter)
		  //tbSearch.Text = filter
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events tbSearch
	#tag Event
		Sub Pressed()
		  PopulateData
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events cbLoadRows
	#tag Event
		Sub SelectionChanged(item As WebMenuItem)
		  PopulateData
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events swOrder
	#tag Event
		Sub ValueChanged()
		  PopulateData
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
