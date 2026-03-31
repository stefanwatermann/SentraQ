#tag Module
 Attributes ( "@Guid" = "37AD9693-5463-4C21-8B6D-292A5F71C435", "@Version" = "1.0.3", "@Copyright" = "(c) 2025 Stefan Watermann", "@Author" = "Stefan Watermann, Auetal", "@Description" = "Line-Of-Business WebApplication helper classes.", "@Depends" = "File v1.2.2, Authentication v1.1.0, WebSessionExtensions v1.1, StringUtils2 V1.0.1, WebConfiguration v1.0, SecureBrowserSession v1.0, StatusRequestService v1.0.3" ) Protected Module LobBase
	#tag Note, Name = History
		v1.0.2 - 2026-02-16
		--------------------
		- CurrentSession
		
		v1.0.2 - 2026-02-03
		--------------------
		- X-API-KEY check no longer fails if only one header is send
		- UpperCase first letter in StatusApi
		
		v1.0.1 - 2025-08-28
		--------------------
		- HandleUrl only service static files from the Html folder
		
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
