#tag Module
 Attributes ( "@Guid" = "03ACD9A9-725A-42D4-88C5-A88953739AF0", "@Version" = "1.0", "@Copyright" = "(c) 2025 Watermann IT, Germany", "@Description" = "TwoFish enc-/decryopt functions" ) Protected Module EncDec
	#tag Method, Flags = &h0
		Function Decrypt(encryptedString as string, password as string) As string
		  Var key As String = MD5(password)
		  Var cleartext As String = Crypto.TwoFishDecrypt(key, DecodeBase64(encryptedString), Crypto.BlockModes.CBC, InitVector)
		  Return cleartext
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Encrypt(clearTextString as string, password as string) As string
		  Var key As String = MD5(password)
		  Var encrypted As String = Crypto.TwoFishEncrypt(key, clearTextString, Crypto.BlockModes.CBC, InitVector)
		  Return EncodeBase64(encrypted)
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private InitVector As string = "0Xaz4f$eqLp08$!b"
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
End Module
#tag EndModule
