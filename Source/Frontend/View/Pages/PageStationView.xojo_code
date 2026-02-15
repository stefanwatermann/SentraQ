#tag WebPage
Begin LobBase.LobWebPage PageStationView
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
   MinimumHeight   =   400
   MinimumWidth    =   600
   PanelIndex      =   0
   RequiresAuthenticatedUser=   True
   ScaleFactor     =   0.0
   TabIndex        =   0
   Title           =   "WWP - Stationen"
   Top             =   0
   Visible         =   True
   Width           =   800
   _ImplicitInstance=   False
   _mDesignHeight  =   0
   _mDesignWidth   =   0
   _mPanelIndex    =   -1
   Begin WebRectangle leftPanel
      BackgroundColor =   &cFFFFFF
      BorderColor     =   &c000000FF
      BorderThickness =   0
      ControlCount    =   0
      ControlID       =   ""
      CornerSize      =   0
      CSSClasses      =   ""
      Enabled         =   True
      FillColor       =   "&cFFFFFF00"
      HasBackgroundColor=   True
      HasFillColor    =   "True"
      Height          =   520
      Index           =   -2147483648
      Indicator       =   ""
      LayoutDirection =   "LayoutDirections.LeftToRight"
      LayoutType      =   "LayoutTypes.Fixed"
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   3
      TabStop         =   True
      Tooltip         =   ""
      Top             =   80
      Visible         =   True
      Width           =   220
      _mDesignHeight  =   0
      _mDesignWidth   =   0
      _mPanelIndex    =   -1
      Begin StationsListContainer StationListContainer1
         ControlCount    =   0
         ControlID       =   ""
         CSSClasses      =   ""
         Enabled         =   True
         Height          =   490
         Index           =   -2147483648
         Indicator       =   0
         InitialParent   =   "leftPanel"
         LayoutDirection =   0
         LayoutType      =   0
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   True
         LockHorizontal  =   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         LockVertical    =   False
         PanelIndex      =   0
         Parent          =   "leftPanel"
         Scope           =   2
         ScrollDirection =   0
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   80
         Visible         =   True
         Width           =   220
         _mDesignHeight  =   0
         _mDesignWidth   =   0
         _mPanelIndex    =   -1
      End
   End
   Begin StationViewContainer StationViewContainer1
      ControlCount    =   0
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      Height          =   490
      Index           =   -2147483648
      Indicator       =   0
      LayoutDirection =   0
      LayoutType      =   0
      Left            =   220
      LockBottom      =   True
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      PanelIndex      =   0
      Scope           =   2
      ScrollDirection =   2
      ShowDebugLog    =   "True"
      TabIndex        =   4
      TabStop         =   True
      Tooltip         =   ""
      Top             =   80
      Visible         =   True
      Width           =   580
      _mDesignHeight  =   0
      _mDesignWidth   =   0
      _mPanelIndex    =   -1
   End
   Begin WebTimer RefreshDataTimer
      ControlID       =   ""
      Enabled         =   True
      Index           =   -2147483648
      Location        =   0
      LockedInPosition=   False
      PanelIndex      =   0
      Period          =   5000
      RunMode         =   2
      Scope           =   2
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
      TabIndex        =   5
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Visible         =   True
      Width           =   800
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
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      LockVertical    =   False
      PanelIndex      =   0
      Scope           =   2
      ScrollDirection =   0
      TabIndex        =   1
      TabStop         =   True
      Tooltip         =   ""
      Top             =   570
      Visible         =   True
      Width           =   760
      _mDesignHeight  =   0
      _mDesignWidth   =   0
      _mPanelIndex    =   -1
   End
End
#tag EndWebPage

#tag WindowCode
	#tag Event
		Sub Opening()
		  RefreshDataTimer.Period = App.ConfigValue("FrontendRefresh.PeriodSec", 5).IntegerValue * 1000
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CreateContainerInstance(base as WebContainer) As WebContainer
		  // a fresh instance is needed because otherwise containers wil 
		  // not be removed correctly by Self.RemoveControl(ctrl) in EmbedViewContainer() (Xojo Bug?)
		  Var instance As IEmbeddableViewContainer = IEmbeddableViewContainer(base)
		  Var type As Introspection.TypeInfo = Introspection.GetType(instance)
		  Var constr() As Introspection.ConstructorInfo = type.GetConstructors
		  
		  If constr.Count = 1 Then
		    // call parameterless default constructor 
		    Return constr(0).Invoke()
		  Else
		    // call second constructor that needs to have one parameter of type variant
		    // see interface IPartnerAdminContainer.Data
		    Var params() As Variant
		    params.Add(instance.GetParam)
		    Return constr(1).Invoke(params)
		  End
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub EmbedViewContainer(cnt as WebContainer, position as Point)
		  RemoveAllEmbeddableViewContainer()
		  
		  Var c As WebContainer = CreateContainerInstance(cnt)
		  
		  Var x As Integer = position.X
		  Var y As Integer = position.Y
		  Var w As Integer = c.Width
		  Var h As Integer = c.Height
		  
		  c.LockLeft = True
		  c.LockRight = True
		  c.LockTop = True
		  c.LockBottom = True
		  c.EmbedWithin(Self, x, y, w, h)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RemoveAllEmbeddableViewContainer()
		  For Each ctrl As WebUiControl In Self.Controls
		    If ctrl IsA IEmbeddableViewContainer Then
		      Self.RemoveControl(ctrl)
		    End
		  Next 
		End Sub
	#tag EndMethod


	#tag Constant, Name = kStationListMaxWidth, Type = Double, Dynamic = False, Default = \"220", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kStationListMinWidth, Type = Double, Dynamic = False, Default = \"53", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events StationListContainer1
	#tag Event
		Sub SelectedStationChanged(station as StationModel)
		  StationViewContainer1.SetStation(station)
		  
		  // update url with selected station
		  Var hashtag As String = DecodeURLComponent(Session.Hashtag)
		  If Not hashtag.Contains(",") Then
		    Session.Hashtag = hashtag + "," + station.Uid
		  Else
		    Session.Hashtag = hashtag.NthField(",", 1) + "," + station.Uid
		  End
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub ChangeSizeClicked()
		  Var w As Integer = kStationListMaxWidth
		  
		  If Me.Width > kStationListMinWidth Then
		    w = kStationListMinWidth
		  End
		  
		  Me.Width = w
		  leftPanel.Width = w
		  StationViewContainer1.Left = w
		  StationViewContainer1.Width = Self.Width - w
		End Sub
	#tag EndEvent
	#tag Event
		Sub Shown()
		  Var station As StationModel = App.DataSvc.GetStationByUid(Session.CurrentSelectedStationUid)
		  
		  If station = Nil And app.DataSvc.Stations.Count > 0 Then
		    station = App.DataSvc.Stations(0)
		  End
		  
		  If station <> Nil Then
		    Me.SelectStationByUid(station.Uid)
		    StationViewContainer1.SetStation(station)
		  end
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RefreshDataTimer
	#tag Event
		Sub Run()
		  StationListContainer1.RefreshData
		  StationViewContainer1.RefreshData
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
