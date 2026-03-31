#tag Class
Protected Class LobWebPageHandler
	#tag Method, Flags = &h0
		Sub Constructor(defaultPage as WebPage, noAccessPage as WebPage, notFoundPage as WebPage)
		  Self.WebPages = New Dictionary
		  Self.DefaultPage = defaultPage
		  Self.NoAccessPage = noAccessPage
		  Self.NotFoundPage = notFoundPage
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RegisterPage(page as WebPage, hashtag as string)
		  If Not Self.WebPages.HasKey(hashtag) Then
		    Self.WebPages.Value(hashtag) = page
		  End
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowPage(hashtag as string)
		  Var pageToShow As WebPage = Self.DefaultPage
		  
		  If hashtag <> "" Then
		    If Self.WebPages.HasKey(hashtag)  Then
		      Var page As WebPage = WebPage(Self.WebPages.Value(hashtag))
		      If page IsA LobBase.LobWebPage Then
		        Var lobPage As LobBase.LobWebPage = LobBase.LobWebPage(page)
		        If (lobPage.RequiresAuthenticatedUser And Session.Authenticator.IsAuthenticatedUser) Or Not lobPage.RequiresAuthenticatedUser Then
		          pageToShow = lobPage
		        Else
		          pageToShow = Self.NoAccessPage
		        End
		      Else
		        pageToShow = page
		      End
		    Else
		      pageToShow = Self. NotFoundPage
		    End
		  End
		  
		  Session.CurrentPage = pageToShow
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private DefaultPage As WebPage
	#tag EndProperty

	#tag Property, Flags = &h21
		Private NoAccessPage As WebPage
	#tag EndProperty

	#tag Property, Flags = &h21
		Private NotFoundPage As WebPage
	#tag EndProperty

	#tag Property, Flags = &h21
		Private WebPages As Dictionary
	#tag EndProperty


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
End Class
#tag EndClass
