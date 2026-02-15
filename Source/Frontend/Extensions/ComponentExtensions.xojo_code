#tag Module
Protected Module ComponentExtensions
	#tag Method, Flags = &h0
		Function GetInfos(extends component as ComponentModel) As String
		  Return kComponentInforHtmlTemplate _
		  .Replace("#HardwareId#", component.HardwareId) _
		  .Replace("#DisplayName#", component.DisplayName) _
		  .Replace("#Type#", component.Type) _
		  .Replace("#CurrentValue#", component.CurrentValue) _
		  .Replace("#LastReceivedTs#", if(component.LastReceivedTs = nil, "-", component.LastReceivedTs.SQLDateTime))
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kComponentInforHtmlTemplate, Type = String, Dynamic = False, Default = \"<raw>\n  <div style\x3D\'margin: 0 20px;\'>\n    <div style\x3D\'font-weight: bold;\'>Komponenteninfo</div>\n    <div style\x3D\'font-size: 0.8em;\'>\n      <div>HardwareId: #HardwareId#</div>\n      <div>Bescheibung: #DisplayName#</div>\n      <div>Typ: #Type#</div>\n      <div>Letzter Wert: #CurrentValue#</div>\n      <div>Emfangen: #LastReceivedTs#</div>\n    </div>\n  </div>\n</raw>", Scope = Private
	#tag EndConstant


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
