#tag Module
 Attributes ( "@Guid" = "F544A9FB-F177-4498-9E93-790C55D37B99", "@Copyright" = "(c)2025 - Stefan Watermann", "@Version" = "1.0.1", "@Author" = "Stefan Watermann", "@Description" = "Model-Binding for WebUiControls" ) Protected Module ModelBinding
	#tag Method, Flags = &h21
		Private Function HasValue(extends popup as WebPopupMenu, value as string) As Boolean
		  For i As Integer = 0 To popup.RowCount - 1
		    If popup.RowTextAt(i) = value Then
		      Return True
		    end
		  Next
		  return false
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateBindValue(extends c as WebUiControl, propertyName as string, value as Variant)
		  If c.Parent <> Nil And c.Parent IsA BindableWebContainer Then
		    Var p As BindableWebContainer = BindableWebContainer(c.Parent)
		    p.UpdateBindValue(propertyName, value)
		  End
		End Sub
	#tag EndMethod


	#tag Note, Name = Create new bindable WebUiControl
		1. Create public class that implement IBindableWebControl
		2. Implement private method IBindableWebControl.ApplyBindValue() with code that sets the controls display value (e.g. Me.Text = value.StringValue)
		3. Create new property "Public Property BindProperty As String"
		4. Create new Event-Defintion for exsiting "Changed" event (e.g. SelectionChanged or ValueChanged) 
		5. Implement regular "Changed" event handler (e.g. SelectionChanged or ValueChanged), set value and raise previously added change event, e.g.:
		      Me.UpdateBindValue(Me.BindProperty, Me.Value)
		      RaiseEvent ValueChanged
		6. Add caption "Model Binding" to InspectorBehavior and move BindProperty to it
		
	#tag EndNote

	#tag Note, Name = History
		v1.0.1 - 2025-09-17
		--------------------
		- BindableWebPopupMenu: if value is a number, SelectedRowIndex is set to value - 1
		
	#tag EndNote

	#tag Note, Name = Usage
		1. Place new WebContainer on a WebPage
		2. Change WebContainer type to ModelBinding.BindableWebContainer
		3. Implement the Bind() event and return an instance of a model class
		4. Place controls on the container and change their type to respective ModelBinding.Bindable... types
		5. Set the "BindProperty" property to the name of a model-property
	#tag EndNote


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
	#tag EndViewBehavior
End Module
#tag EndModule
