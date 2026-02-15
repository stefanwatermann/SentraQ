#tag Class
Protected Class BindableWebContainer
Inherits WebContainer
	#tag Event
		Sub Shown()
		  RaiseEvent BeforeBinding
		  BindProperties(RaiseEvent Bind)
		  RaiseEvent Shown
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub ApplyBindValue(ctl as WebUIControl, value as Variant)
		  If ctl IsA IBindableWebControl Then
		    Var c As IBindableWebControl = IBindableWebControl(ctl)
		    c.ApplyBindValue(value)
		  End
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub BindProperties(model as Object)
		  Using Introspection
		  
		  Self.Model = model
		  
		  Self.BindableModelProperties.RemoveAll
		  
		  If Self.Model <> Nil Then
		    
		    Var modelType As TypeInfo = GetType(Self.Model)
		    
		    For Each p As PropertyInfo In modelType.GetProperties()
		      
		      If Not HasAttribute(p, "#BindIgnore") Then
		        
		        If p.IsPublic And p.CanRead Then
		          
		          Var ctls() As WebUIControl = FindBindableControls(p.Name)
		          
		          If ctls.Count > 0 Then
		            
		            For Each ctl As WebUIControl In ctls
		              
		              Self.BindableModelProperties.Add(p)
		              
		              //If Not p.Value(Self.Model).IsNull Then
		              Self.ApplyBindValue(ctl, p.Value(Self.Model))
		              //End
		              
		              Debug("BindableWebContainer: Property '" + p.Name + "' successfully bound to control '" + ctl.Name + "'.")
		              
		            Next
		            
		          Else
		            Debug("BindableWebContainer: Property '" + p.Name + "' not bound because no bindable control with property-name found.")
		            
		          End
		          
		        Else
		          Debug("BindableWebContainer: Property '" + p.Name + "' not bound because not public or not readable.")
		          
		        End
		        
		      Else
		        Debug("BindableWebContainer: Property '" + p.Name + "' not bound because of #BindIgnore attribute.")
		        
		      End
		      
		    Next
		    
		  End
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Debug(s as string)
		  If ShowDebugLog Then
		    System.DebugLog(s)
		  end
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function FindBindableControls(propertyName as string) As WebUiControl()
		  Using Introspection
		  
		  Var foundControls() As WebUIControl
		  
		  For Each ctl As WebUIControl In Self.Controls
		    
		    Var t As TypeInfo = GetType(ctl)
		    
		    Var props() As PropertyInfo = t.GetProperties()
		    For Each p As PropertyInfo In props
		      
		      If p.Name = "BindProperty" Then
		        If p.Value(ctl).StringValue = propertyName Then
		          foundControls.Add(ctl)
		        End
		      End
		    Next
		    
		  Next
		  
		  Return foundControls() 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function HasAttribute(p as Introspection.PropertyInfo, name as string) As Boolean
		  Var attribs() As Introspection.AttributeInfo = p.GetAttributes
		  For Each a As Introspection.AttributeInfo In attribs
		    if a.Name = name then return True
		  Next
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateBindValue(propertyName as string, value as Variant)
		  Using Introspection
		  
		  If propertyName <> "" Then
		    For Each p As PropertyInfo In Self.BindableModelProperties
		      If p.Name = propertyName Then
		        If p.CanWrite Then
		          p.Value(Self.Model) = value
		          Debug("BindableWebContainer: Model-Property '" + p.Name + "' changed.")
		          RaiseEvent ModelPropertyValueChanged(p.Name, value)
		        End
		      End
		    Next
		  End
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event BeforeBinding()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Bind() As Object
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ModelPropertyValueChanged(name as string, value as Variant)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Shown()
	#tag EndHook


	#tag Property, Flags = &h21
		Private BindableModelProperties() As Introspection.PropertyInfo
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Model As Object
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  #If DebugBuild Then
			    Return True
			  #Else
			    Return False
			  #EndIf
			End Get
		#tag EndGetter
		ShowDebugLog As Boolean
	#tag EndComputedProperty


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
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Behavior"
			InitialValue="300"
			Type="Integer"
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
			Name="Width"
			Visible=true
			Group="Behavior"
			InitialValue="300"
			Type="Integer"
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
	#tag EndViewBehavior
End Class
#tag EndClass
