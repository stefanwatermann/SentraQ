#tag WebContainerControl
Begin WebContainer BarChartContainer
   Compatibility   =   ""
   ControlCount    =   0
   ControlID       =   ""
   CSSClasses      =   ""
   Enabled         =   True
   Height          =   250
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
   Width           =   600
   _mDesignHeight  =   0
   _mDesignWidth   =   0
   _mPanelIndex    =   -1
   Begin WebChart Chart1
      AllowPopover    =   True
      AutoCalculateYAxis=   False
      ControlID       =   ""
      CSSClasses      =   ""
      DatasetCount    =   0
      DatasetLastIndex=   0
      Enabled         =   True
      GridColor       =   &c000000AA
      HasAnimation    =   False
      HasLegend       =   False
      Height          =   200
      Index           =   -2147483648
      Indicator       =   ""
      IsGridVisible   =   False
      IsXAxisVisible  =   False
      IsYAxisVisible  =   False
      LabelCount      =   0
      LabelLastIndex  =   0
      Left            =   20
      LegendColor     =   
      LegendFontName  =   ""
      LegendFontSize  =   0.0
      LockBottom      =   True
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      Mode            =   1
      PanelIndex      =   0
      PopoverBackgroundColor=   &c000000
      Scope           =   2
      TabIndex        =   0
      TabStop         =   True
      Title           =   ""
      TitleColor      =   
      TitleFontName   =   ""
      TitleFontSize   =   0.0
      Tooltip         =   ""
      Top             =   10
      Visible         =   True
      Width           =   560
      _mMode          =   ""
      _mPanelIndex    =   -1
   End
   Begin WebSegmentedButton sbPeriode
      ControlID       =   ""
      CSSClasses      =   "small padding-0"
      Enabled         =   True
      Height          =   22
      Index           =   -2147483648
      Indicator       =   0
      LastSegmentIndex=   0
      Left            =   150
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
      SegmentCount    =   0
      Segments        =   "24 Stunden\n\nTrue\r30 Tage\n\nFalse\r90 Tage\n\nFalse"
      SelectedSegmentIndex=   0
      SelectionStyle  =   1
      TabIndex        =   1
      TabStop         =   True
      Tooltip         =   ""
      Top             =   220
      Visible         =   True
      Width           =   300
      _mPanelIndex    =   -1
   End
   Begin WebLabel lbHint
      Bold            =   False
      ControlID       =   ""
      CSSClasses      =   "small"
      Enabled         =   True
      FontName        =   ""
      FontSize        =   0.0
      Height          =   22
      HTMLElement     =   0
      Index           =   -2147483648
      Indicator       =   0
      Italic          =   False
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      LockVertical    =   False
      Multiline       =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   2
      TabStop         =   True
      Text            =   "---"
      TextAlignment   =   3
      TextColor       =   &c5E5E5E00
      Tooltip         =   ""
      Top             =   220
      Underline       =   False
      Visible         =   True
      Width           =   140
      _mPanelIndex    =   -1
   End
End
#tag EndWebContainerControl

#tag WindowCode
	#tag Method, Flags = &h0
		Sub Render(component as ComponentModel)
		  Self.Component = component
		  Self.RenderChart
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RenderChart()
		  Var aggregations() As AggregationModel = App.DataSvc.GetAggregations(self.ChartPeriode, self.Component.HardwareId, ChartTake)
		  
		  Var labels() As String
		  Var data() As Double
		  
		  For Each aggregation As AggregationModel In aggregations
		    labels.Add(aggregation.DateBin.ToString(LabelStringFormat))
		    data.Add(aggregation.Sum)
		  Next
		  
		  Var ds As New ChartLinearDataset(Self.Component.DisplayUnit, &c00919300, True, data)
		  
		  Chart1.RemoveAllDatasets
		  Chart1.AddDatasets(ds)
		  
		  Chart1.RemoveAllLabels
		  Chart1.AddLabels(labels)
		  
		  lbHint.Text = LabelHintText
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  If Component.TypeDef = Enums.ComponentTypes.FillLevel Or _
			    Component.TypeDef = Enums.ComponentTypes.Sensor then
			    Return If(sbPeriode.SelectedSegmentIndex = 0, "Avg1h", "Avg1d")
			  Else
			    Return If(sbPeriode.SelectedSegmentIndex = 0, "Sum1h", "Sum1d")
			  end
			End Get
		#tag EndGetter
		Private ChartPeriode As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Select Case sbPeriode.SelectedSegmentIndex
			  Case 1
			    Return 30
			  Case 2
			    Return 90
			  Else
			    Return  24
			  end
			End Get
		#tag EndGetter
		Private ChartTake As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private Component As ComponentModel
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  if ChartPeriode.Contains("Avg") then
			    Return "<raw>&Oslash; der letzten</raw>"
			  Else
			    Return "<raw>&sum;  der letzten</raw>"
			  end
			End Get
		#tag EndGetter
		Private LabelHintText As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  return If(Self.ChartPeriode.Contains("1h"), "HH:00", "dd.MM")
			End Get
		#tag EndGetter
		Private LabelStringFormat As String
	#tag EndComputedProperty


#tag EndWindowCode

#tag Events Chart1
	#tag Event
		Sub Opening()
		  Me.IsGridVisible = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events sbPeriode
	#tag Event
		Sub Pressed(segmentIndex As Integer)
		  RenderChart
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
