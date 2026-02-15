#tag Module
 Attributes ( "@Guid" = "962F441F-E739-416C-B7C9-93C3DCFE6DA6", "@Author" = "Brock Nash", "@Copyright" = "(c) 2020 Brock Nash", "@Description" = "FlexLayout with Xojo Containers.", "@Version" = "1.0", "@Category" = "Xojo Web 2.0" ) Protected Module BootstrapFlexContainer
	#tag Method, Flags = &h0
		Sub AddResponsiveLayout(extends control as WebUIControl, ColXS as integer = -1, ColSm as integer = -1, ColMd as integer = -1, ColLg as integer = -1, ColXl as integer = -1)
		  Dim classesToAdd() As String
		  //-1 = inherit
		  if ColSm = -1 then ColSm = ColXS
		  if ColMd = -1 then ColMd = ColSm
		  if ColLg = -1 then ColLg = ColMd
		  if ColXl = -1 then ColXl = ColLg
		  //0 = hidden https://getbootstrap.com/docs/4.0/utilities/display/
		  if colxs = 0 or colsm = 0 or colmd = 0 or collg = 0 or colxl = 0 then //If Any Hidden
		    if ColXs = 0 then classesToAdd.Append("d-none") else classesToAdd.Append("d-block")
		    if ColSm = 0 then classesToAdd.Append("d-sm-none") else classesToAdd.Append("d-sm-block")
		    if ColMd = 0 then classesToAdd.Append("d-md-none") else classesToAdd.Append("d-md-block")
		    if ColLg = 0 then classesToAdd.Append("d-lg-none") else classesToAdd.Append("d-lg-block")
		    if ColXl = 0 then classesToAdd.Append("d-xl-none") else classesToAdd.Append("d-xl-block")
		  end
		  //1-12 https://getbootstrap.com/docs/4.0/layout/grid/
		  if ColXs > 0 then classesToAdd.Append("col-"+ColXs.ToString)
		  if ColSm > 0 then classesToAdd.Append("col-sm-"+ColSm.ToString)
		  if ColMd > 0 then classesToAdd.Append("col-md-"+ColMd.ToString)
		  if ColLg > 0 then classesToAdd.Append("col-lg-"+ColLg.ToString)
		  if ColXl > 0 then classesToAdd.Append("col-xl-"+ColXl.ToString)
		  
		  //ADD CLASSES
		  for each classToAdd as string in classesToAdd
		    dim js as string = "document.getElementById('"+control.ControlId+"').classList.add('"+classToAdd+"');"
		    control.ExecuteJavaScript(js)
		  next
		End Sub
	#tag EndMethod


	#tag Note, Name = Readme
		FlexLayout with Xojo Containers
		
		Based on https://forum.xojo.com/t/how-to-manage-responsive-design/56669/18
		
		"AddResponsiveLayout is a custom method so you can specify the number columns 
		for XS,Small,Medium,Large, and XL screens based on a 12 column system. Use this 
		if you want your controls to stretch to fill up the space evenly."
	#tag EndNote

	#tag Note, Name = Usage
		1) Create an empty Container with default size
		
		2) In Open() event embedd other containers that shall be responsive
		
		Event Container.Open()
		BEGIN
		
		  // set container to flex-layout
		  Self.LayoutType = LayoutTypes.Flex
		
		  For i As Integer = 0 To 5
		    // add flex containers with controls as usual
		    dim cc as new MyCustomContainerWithFixedControls
		
		    // embedd container
		    cc.EmbedWithin(Self, Self.Width, cc.Height)
		
		    // configure flex layout for each embedded container
		    cc.AddResponsiveLayout(12,6,4,3,2)
		  next
		
		END
		
		3) Place container in WebPage and stick to top, left and right
		
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
