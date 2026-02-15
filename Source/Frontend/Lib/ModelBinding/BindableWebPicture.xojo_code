#tag Class
Protected Class BindableWebPicture
Inherits WebCanvas
Implements ModelBinding.IBindableWebControl
	#tag Event
		Sub Paint(g As WebGraphics)
		  RaiseEvent BeforePaint(g)
		  
		  If mValue <> Nil Then
		    Var x As Integer = 0
		    Var y As Integer = 0
		    Var w As Integer = mValue.Width
		    Var h As Integer = mValue.Height
		    
		    If Scaled Then
		      If mValue.Width > g.Width Then
		        w = g.Width
		        h = mValue.Height * g.Width / mValue.Width
		      End
		      If h > g.Height Then
		        w = g.Width * g.Height / h
		        h = g.Height
		      End
		    End
		    
		    If Centered Then
		      x = (g.Width - w) / 2
		      y = (g.Height - h) / 2
		    End
		    
		    g.DrawPicture(mValue, x, y, w, h)
		    
		    If BorderSize > 0 Then
		      If BorderColor <> Nil Then
		        g.DrawingColor = BorderColor
		      End
		      g.PenSize = BorderSize
		      Var z As Integer = g.PenSize / 2
		      g.DrawRoundRectangle(z, z, g.Width - 2*z, g.Height - 2*z, BorderRadius)
		    End
		  End
		  
		  RaiseEvent AfterPaint(g)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub ApplyBindValue(value as Variant)
		  // Part of the ModelBinding.IBindableWebControl interface.
		  If value IsA Picture Then
		    Var v As Picture = Picture(value)
		    Me.Value = v
		  end
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event AfterPaint(g as WebGraphics)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event BeforePaint(g as WebGraphics)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ValueChanged()
	#tag EndHook


	#tag Property, Flags = &h0
		BindProperty As String
	#tag EndProperty

	#tag Property, Flags = &h0
		BorderColor As ColorGroup
	#tag EndProperty

	#tag Property, Flags = &h0
		BorderRadius As Integer = 10
	#tag EndProperty

	#tag Property, Flags = &h0
		BorderSize As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		Centered As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mValue As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		Scaled As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mValue
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mValue = value
			  me.UpdateBindValue(Me.BindProperty, value)
			  Me.Refresh
			  RaiseEvent ValueChanged
			End Set
		#tag EndSetter
		Value As Picture
	#tag EndComputedProperty


	#tag ViewBehavior
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
			InitialValue="100"
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
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Value"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Centered"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Scaled"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BorderSize"
			Visible=true
			Group="Behavior"
			InitialValue="1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BorderColor"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BorderRadius"
			Visible=true
			Group="Behavior"
			InitialValue="6"
			Type="Integer"
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
			Name="DiffEngineDisabled"
			Visible=true
			Group="Canvas"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BindProperty"
			Visible=true
			Group="Model Binding"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
			Name="_mPanelIndex"
			Visible=false
			Group="Behavior"
			InitialValue="-1"
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
			Name="ControlID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_mName"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
