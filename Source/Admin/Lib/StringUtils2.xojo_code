#tag Module
 Attributes ( "@Version" = "1.0.1", "@Copyright" = "watermann-it.de", "@Guid" = "AA1C8547-E9DE-4408-95A4-820372E3EC79", "@Author" = "Stefan Watermann", "@Description" = "Extensions to string, without BeginsWith, EndWith and Contains." ) Protected Module StringUtils2
	#tag Method, Flags = &h0
		Sub AddLine(extends s() as string, line as string)
		  s.Add(line + EndOfLine)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateSafeFilename(extends filename as string, replaceCharacter as string = "_") As String
		  If Left(filename, 1) = "." Then 
		    filename = filename.Replace(".", replaceCharacter)
		  End
		  
		  Return Left(filename. _
		  ReplaceAll(":", replaceCharacter). _
		  ReplaceAll("?", replaceCharacter). _
		  ReplaceAll("/", replaceCharacter). _
		  ReplaceAll("\", replaceCharacter). _
		  ReplaceAll("$", replaceCharacter). _
		  ReplaceAll("""", replaceCharacter). _
		  ReplaceAll("<", replaceCharacter). _
		  ReplaceAll(">", replaceCharacter). _
		  ReplaceAll("*", replaceCharacter). _
		  ReplaceAll("|", replaceCharacter), 255)
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NewGuid() As String
		  // From http://www.cryptosys.net/pki/uuid-rfc4122.html
		  //
		  // Generate 16 random bytes (=128 bits)
		  // Adjust certain bits according to RFC 4122 section 4.4 as follows:
		  // set the four most significant bits of the 7th byte to 0100'B, so the high nibble is '4'
		  // set the two most significant bits of the 9th byte to 10'B, so the high nibble will be one of '8', '9', 'A', or 'B'.
		  // Convert the adjusted bytes to 32 hexadecimal digits
		  // Add four hyphen '-' characters to obtain blocks of 8, 4, 4, 4 and 12 hex digits
		  // Output the resulting 36-character string "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
		  
		  Dim randomBytes As MemoryBlock = Crypto.GenerateRandomBytes(16)
		  randomBytes.LittleEndian = False
		  
		  //
		  // Adjust seventh byte
		  //
		  Dim value As Byte = randomBytes.Byte(6)
		  value = value And &b00001111 // Turn off the first four bits
		  value = value Or &b01000000 // Turn on the second bit
		  randomBytes.Byte(6) = value
		  
		  //
		  // Adjust ninth byte
		  //
		  value = randomBytes.Byte(8)
		  value = value And &b00111111 // Turn off the first two bits
		  value = value Or &b10000000 // Turn on the first bit
		  randomBytes.Byte(8) = value
		  
		  
		  Dim result As String = EncodeHex(randomBytes)
		  result = result.LeftB(8) + "-" + result.MidB(9, 4) + "-" + result.MidB(13, 4) + "-" + result.MidB(17, 4) + _
		  "-" + result.RightB(12)
		  
		  Return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PadRight(Extends s as string, length as integer, character as string = " ") As string
		  If length - s.Length < 0 Then
		    Return s
		  Else
		    Var c() As String
		    Redim c(length - s.Length)
		    Return s + Join(c, " ")
		  End
		End Function
	#tag EndMethod


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
