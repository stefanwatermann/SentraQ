#tag WebContainerControl
Begin WebContainer StationViewComponentsContainer
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
   Width           =   250
   _mDesignHeight  =   0
   _mDesignWidth   =   0
   _mName          =   ""
   _mPanelIndex    =   -1
End
#tag EndWebContainerControl

#tag WindowCode
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
		Private Function EmbedViewContainer(cnt as WebContainer, maxWidth as Boolean) As WebContainer
		  Var c As WebContainer = CreateContainerInstance(cnt)
		  
		  // embedd container
		  If maxWidth Then
		    c.LockLeft = maxWidth
		    c.LockRight = maxWidth
		    c.EmbedWithin(Self, Self.Width, c.Height)
		  Else
		    c.EmbedWithin(Self, c.Width, c.Height)
		    c.AddResponsiveLayout(12,6,4,2,1)
		  End
		  
		  return c
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PopulateComponents()
		  // set container to flex-layout
		  Self.LayoutType = LayoutTypes.Flex
		  
		  RemoveAllEmbeddableViewContainer
		  
		  // init single message view container (for alerts etc.)
		  Var messagesContainer As ComponentMessageViewContainer 
		  If HasFaultComponents Then
		    messagesContainer = ComponentMessageViewContainer(EmbedViewContainer(New ComponentMessageViewContainer(), True))
		  End
		  
		  // init all other components
		  For Each component As ComponentModel In Self.Components
		    
		    Var maxWidth As Boolean = False
		    Var container As WebContainer
		    
		    If component.TypeDef = Enums.ComponentTypes.FillLevel Then
		      container = New ComponentViewFillLevelContainer(component)
		      
		    ElseIf component.TypeDef = Enums.ComponentTypes.Counter Then
		      container = New ComponentCounterViewContainer(component)
		      
		    ElseIf component.TypeDef = Enums.ComponentTypes.Fault Then
		      // alerts are collected in the single message-container
		      messagesContainer.Add(component)
		      
		    ElseIf component.TypeDef = Enums.ComponentTypes.Divider Then
		      container = New ComponentDividerViewContainer(component)
		      maxWidth = True
		      
		    ElseIf component.TypeDef = Enums.ComponentTypes.Actor Then
		      container = New ComponentActorViewContainer(component)
		      
		    Else
		      container = New ComponentViewContainer(component)
		      
		    End
		    
		    If container <> Nil Then
		      // not all components add an container (e.g. Alert)
		      Call EmbedViewContainer(container, maxWidth)
		    End
		    
		  Next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RefreshData()
		  If Self.Components <> Nil Then
		    
		    For Each ctrl As WebUiControl In Self.Controls
		      If ctrl IsA IEmbeddableViewContainer Then
		        Var c As IEmbeddableViewContainer = IEmbeddableViewContainer(ctrl)
		        c.UpdateControls()
		      End
		    Next 
		    
		  End
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

	#tag Method, Flags = &h0
		Sub SetComponents(components() as ComponentModel)
		  Self.Components = components
		  Self.PopulateComponents
		  self.RefreshData
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Components() As ComponentModel
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  For Each component As ComponentModel In Components
			    If component.TypeDef = Enums.ComponentTypes.Fault Then
			      Return True
			    End
			  Next
			  return false
			End Get
		#tag EndGetter
		Private HasFaultComponents As Boolean
	#tag EndComputedProperty


#tag EndWindowCode

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
