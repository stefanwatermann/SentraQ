#tag Module
 Attributes ( "@Version" = "1.2.2", "@Copyright" = "(c) 2022 - watermann-it.de", "@Guid" = "91FE84EC-3D79-415A-9EE7-3E6DB1FF9150", "@History" = "Read/Write CSV added; Read/Write lines() added; iOS Support" ) Protected Module File
	#tag Method, Flags = &h0
		Sub AppendText(f as FolderItem, data as string)
		  WriteAllText(f, data, Encodings.UTF8, true)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AppendText(f as FolderItem, data as string, enc as TextEncoding)
		  WriteAllText(f, data, enc, true)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AppendText(filePath as string, data as string)
		  Var f As FolderItem = New FolderItem(filePath, Folderitem.PathModes.Native)
		  WriteAllText(f, data, Encodings.UTF8, True)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Delete(filePath as string)
		  Var f As FolderItem = New FolderItem(filePath, Folderitem.PathModes.Native)
		  f.Remove
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReadAllBytes(f as FolderItem) As MemoryBlock
		  Var t As BinaryStream = BinaryStream.Open(f, False)
		  Var raw As MemoryBlock = t.Read(f.Length)
		  t.Close
		  Return raw
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReadAllLines(f as FolderItem) As string()
		  Return ReadAllLines(f, encodings.UTF8)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReadAllLines(f as FolderItem, enc as TextEncoding) As string()
		  If enc = Nil Then
		    enc = encodings.UTF8
		  End
		  
		  Var data() As String
		  
		  Var t As TextInputStream = TextInputStream.Open(f)
		  t.Encoding = enc
		  
		  Do
		    data.Add(t.ReadLine)
		  Loop Until t.EndOfFile
		  
		  t.Close
		  
		  Return data
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 526561647320616C6C207465787420646174612066726F6D2061205554463820656E636F6465642066696C65
		Function ReadAllText(f as FolderItem) As string
		  Return ReadAllText(f, Encodings.UTF8)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReadAllText(f as FolderItem, enc as TextEncoding) As string
		  If enc = Nil Then
		    enc = encodings.UTF8
		  End
		  
		  Var data As String
		  
		  Var t As TextInputStream = TextInputStream.Open(f)
		  t.Encoding = enc
		  data = t.ReadAll
		  t.Close
		  
		  Return data
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReadAllText(filePath as string) As string
		  Var f As FolderItem = New FolderItem(filePath, Folderitem.PathModes.Native)
		  Return ReadAllText(f)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 526561647320616C6C207465787420646174612066726F6D2061205554463820656E636F6465642066696C6520617320435356206461746120616E642072657475726E7320612044696374696F6E6172792077697468206C696E65206E756D62657220617320696E64657820616E64206120737472696E672061727261792061732076616C7565
		Function ReadCsv(f as FolderItem, fieldSeperator as String = ";", idFieldNr as integer = -1) As Dictionary
		  Var lines() As String = ReadAllLines(f, Encodings.UTF8)
		  
		  Var d As New Dictionary
		  
		  For i As Integer = 0 To lines.Count - 1
		    Var fields() As String = lines(i).Split(fieldSeperator)
		    
		    If idFieldNr < 0 Then
		      d.Value(i) = fields
		    Else
		      d.Value(fields(idFieldNr)) = fields
		    End
		    
		  Next
		  
		  Return d
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub WriteAllBytes(f as folderitem, bytes as MemoryBlock)
		  Var t As BinaryStream = BinaryStream.Create(f, True)
		  t.Write(bytes)
		  t.Close
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 777269746520616C6C207465787420746F2066696C65207573696E67205554463820656E636F64696E67
		Sub WriteAllLines(f as folderitem, data() as string, append as Boolean = false)
		  WriteAllLines(f, data, encodings.UTF8, append)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 777269746520616C6C207465787420746F2066696C65207573696E67205554463820656E636F64696E67
		Sub WriteAllLines(f as folderitem, data() as string, enc as TextEncoding, append as Boolean = false)
		  If enc = Nil Then
		    enc = encodings.UTF8
		  End
		  
		  Var t As TextOutputStream 
		  
		  If append Then
		    t = TextOutputStream.Open(f)
		  Else
		    t = TextOutputStream.Create(f)
		  End
		  
		  t.Encoding = enc
		  
		  For i As Integer = 0 To data.Count -1
		    t.WriteLine(data(i))
		  Next
		  
		  t.Close
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 777269746520616C6C207465787420746F2066696C65207573696E67205554463820656E636F64696E67
		Sub WriteAllText(f as folderitem, data as string)
		  WriteAllText(f, data, Encodings.UTF8)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub WriteAllText(f as folderitem, data as string, enc as TextEncoding, append as Boolean = false)
		  If enc = Nil Then
		    enc = encodings.UTF8
		  End
		  
		  Var t As TextOutputStream 
		  
		  If append Then
		    t = TextOutputStream.Open(f)
		  Else
		    t = TextOutputStream.Create(f)
		  End
		  
		  t.Encoding = enc
		  t.Write(data)
		  t.Close
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub WriteAllText(filePath as string, data as string)
		  Var f As FolderItem = New FolderItem(filePath, Folderitem.PathModes.Native)
		  WriteAllText(f, data)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4578706563747320612064696374696F6E6172792077697468206C696E65206E756D62657220617320696E64657820616E6420737472696E672061727261792061732076616C75652E
		Sub WriteCsv(data as dictionary, f as FolderItem, fieldSeperator as String = ";")
		  Var s() As String
		  
		  For Each item As DictionaryEntry In data
		    Var fields() As String = item.Value
		    s.Add(String.FromArray(fields, fieldSeperator))
		  Next
		  
		  WriteAllLines(f, s)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function WriteTemp(data as string) As FolderItem
		  #If Not TargetIOS Then
		    Var f As FolderItem = FolderItem.TemporaryFile
		    WriteAllText(f, data)
		    Return f
		  #EndIf
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
