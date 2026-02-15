#tag WebContainerControl
Begin WebContainer WebListMenu Attributes ( "@Guid" = "DA5C2FC6-7925-4879-907A-B94E33D7032A", "@Copyright" = "(c)2026 Stefan Watermann", "@Version" = "1.0", "@Description" = "Ein Listen-Menü für Web Apps.", "@Author" = "Stefan Watermann, Auetal", "@Depends" = "CallbackControl 1.0" ) 
   Compatibility   =   ""
   ControlCount    =   0
   ControlID       =   ""
   CSSClasses      =   "vh-100"
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
   Begin WebHTMLViewer HTMLViewer1 Attributes ( "@Guid" = "DA5C2FC6-7925-4879-907A-B94E33D7032A", "@Copyright" = "(c)2026 Stefan Watermann", "@Version" = "1.0", "@Description" = "Ein Listen-Menü für Web Apps.", "@Author" = "Stefan Watermann, Auetal", "@Depends" = "CallbackControl 1.0" ) 
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      Height          =   250
      Index           =   -2147483648
      Indicator       =   0
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      UseSandbox      =   False
      Visible         =   True
      Width           =   250
      _mPanelIndex    =   -1
   End
   Begin CallbackControl CallbackControl1 Attributes ( "@Guid" = "DA5C2FC6-7925-4879-907A-B94E33D7032A", "@Copyright" = "(c)2026 Stefan Watermann", "@Version" = "1.0", "@Description" = "Ein Listen-Menü für Web Apps.", "@Author" = "Stefan Watermann, Auetal", "@Depends" = "CallbackControl 1.0" ) 
      ControlID       =   ""
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      PanelIndex      =   0
      Scope           =   2
      _mPanelIndex    =   -1
   End
End
#tag EndWebContainerControl

#tag WindowCode
	#tag Event
		Sub Opening()
		  RaiseEvent Opening
		  RenderMenu()
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub AddMenuItem(key as variant, caption as string)
		  self.ListItems.Value(key) = caption
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.ListItems = New Dictionary
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RenderMenu()
		  Var items() As String
		  For Each key As Variant In ListItems.Keys
		    Var caption As String = ListItems.Value(key)
		    Var active As String = ""
		    If key = SelectedKey Then
		      active = "active"
		    End
		    Var menuItem As String = kListGroupItem.Replace("{caption}", caption).Replace("{callback}", CallbackControl1.MakeCallback("clicked", Str(key))).Replace("{active}", active)
		    items.Add(menuItem)
		  Next
		  
		  Var html As String = kListGroup.Replace("{items}", String.FromArray(items, EndOfLine))
		  HTMLViewer1.LoadHTML(html)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateMenuItem(key as variant, caption as string)
		  If ListItems.HasKey(key) Then
		    ListItems.Value(key) = caption
		    RenderMenu
		  End
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ItemSelected(key as Variant)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Opening()
	#tag EndHook


	#tag Note, Name = WICHTIG!
		Im Projekt muss das "CallbackControl" aus dem WebSDK vorhanden sein.
		
		Nachfolgendes JavaScript muss in die Seite eingefügt werden (App.HTMLHeader):
		
		<script type="text/javascript">
		function SelectWebMenuItem(sender) {
		  let elems = sender.parentElement.getElementsByClassName("list-group-item-action");
		  for (const el of elems) {
		    el.classList.remove("active");
		  }
		  sender.classList.add("active");
		}
		</script>
		
		
		
		Nachfolgendes CSS legt die Farben des markierten Eintrags fest:
		
		<style>
		.list-group-item.active {
		  background-color: #C0C0C0;
		  border-color: #C0C0C0;
		  color: black;
		}
		</style>
		
	#tag EndNote


	#tag Property, Flags = &h21
		Private ListItems As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectedKey As Variant
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mSelectedKey
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mSelectedKey = value
			  RenderMenu
			End Set
		#tag EndSetter
		SelectedKey As Variant
	#tag EndComputedProperty


	#tag Constant, Name = kCustomScript, Type = String, Dynamic = False, Default = \"function SelectWebMenuItem(sender) {\n  let elems \x3D sender.parentElement.getElementsByClassName(\"list-group-item-action\");\n  for (const el of elems) {\n    el.classList.remove(\"active\");\n  }\n  sender.classList.add(\"active\");\n}", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kListGroup, Type = String, Dynamic = False, Default = \"<div class\x3D\"list-group list-group-flush h-100\">\n{items}\n</div>", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kListGroupItem, Type = String, Dynamic = False, Default = \"<button type\x3D\"button\" class\x3D\"list-group-item list-group-item-action border-0 d-flex justify-content-between align-items-start text-nowrap align-items-center {active}\" onclick\x3D\"javascript:SelectWebMenuItem(this);{callback}\">{caption}</button>", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events HTMLViewer1
	#tag Event
		Sub Opening()
		  me.ExecuteJavaScript(kCustomScript)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CallbackControl1
	#tag Event
		Sub BrowserCallback(method as string, parameters as jsonitem)
		  If method = "clicked" Then
		    SelectedKey = parameters.Value("data")
		    RaiseEvent ItemSelected(SelectedKey)
		  End
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
