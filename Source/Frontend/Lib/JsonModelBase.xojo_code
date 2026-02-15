#tag Class
 Attributes ( "@Version" = "1.2.4", "@Copyright" = "(c) 2022-2025 watermann-it.de", "@Guid" = "7391BC4F-5E17-4EED-A7FC-7D000EF67BA5", "@Author" = "Stefan Watermann", "@Description" = "Base-class used for model-classes to convert to and from JSON. Recursive JSON Support.", "@Depends" = "-", "@History" = "Fix missing encoding for ToJson. ToJson as JSONItem. Handling MemoryBlock types. Support for #JsonIgnore attribute." ) Protected Class JsonModelBase
	#tag Method, Flags = &h21
		Private Shared Function CreateArray(p as Introspection.PropertyInfo, json as JSONItem) As Variant
		  Var values() As Variant = ParseJSON(json.ToString)
		  
		  If p.PropertyType.Name = "String()" Then
		    Var a() As String
		    For Each v As Variant In values
		      a.Add(v.StringValue)
		    Next
		    Return a
		  End
		  
		  If p.PropertyType.Name = "DateTime()" Then
		    Var a() As DateTime
		    For Each v As Variant In values
		      a.Add(v.DateTimeValue)
		    Next
		    Return a
		  End
		  
		  If p.PropertyType.Name = "Integer()" Then
		    Var a() As Integer
		    For Each v As Variant In values
		      a.Add(v.IntegerValue)
		    Next
		    Return a
		  End
		  
		  If p.PropertyType.Name = "Int32()" Then
		    Var a() As Int32
		    For Each v As Variant In values
		      a.Add(v.Int32Value)
		    Next
		    Return a
		  End
		  
		  If p.PropertyType.Name = "Int64()" Then
		    Var a() As Int64
		    For Each v As Variant In values
		      a.Add(v.Int64Value)
		    Next
		    Return a
		  End
		  
		  If p.PropertyType.Name = "Double()" Then
		    Var a() As Double
		    For Each v As Variant In values
		      a.Add(v.DoubleValue)
		    Next
		    Return a
		  End
		  
		  If p.PropertyType.Name = "Single()" Then
		    Var a() As Single
		    For Each v As Variant In values
		      a.Add(v.SingleValue)
		    Next
		    Return a
		  End
		  
		  If p.PropertyType.Name = "Boolean()" Then
		    Var a() As Boolean
		    For Each v As Variant In values
		      a.Add(v.BooleanValue)
		    Next
		    Return a
		  End
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromDatabaseRow(row as DatabaseRow, o as Object) As Object
		  Using Introspection
		  
		  Var t As Introspection.TypeInfo = Introspection.GetType(o)
		  
		  For Each p As PropertyInfo In t.GetProperties
		    If p.IsPublic And p.CanWrite And Not p.IsComputed And Not JsonModelBase.HasAttribute(p, "#JsonIgnore") Then
		      
		      If row.Column(p.Name) <> Nil Then
		        
		        If p.PropertyType.FullName = "String" Then
		          p.Value(o) = row.Column(p.Name).StringValue
		        ElseIf p.PropertyType.FullName = "DateTime" Then
		          p.Value(o) = row.Column(p.Name).DateTimeValue
		        ElseIf p.PropertyType.FullName = "Integer" Then
		          p.Value(o) = row.Column(p.Name).IntegerValue
		        ElseIf p.PropertyType.FullName = "Int32" Then
		          p.Value(o) = row.Column(p.Name).IntegerValue
		        ElseIf p.PropertyType.FullName = "Int64" Then
		          p.Value(o) = row.Column(p.Name).Int64Value
		        ElseIf p.PropertyType.FullName = "Double" Then
		          p.Value(o) = row.Column(p.Name).DoubleValue
		        ElseIf p.PropertyType.FullName = "Currency" Then
		          p.Value(o) = row.Column(p.Name).CurrencyValue
		        ElseIf p.PropertyType.FullName = "Boolean" Then
		          p.Value(o) = row.Column(p.Name).BooleanValue
		        ElseIf p.PropertyType.FullName = "Picture" Then
		          p.Value(o) = row.Column(p.Name).PictureValue
		        ElseIf p.PropertyType.FullName = "MemoryBlock" Then
		          p.Value(o) = CType(row.Column(p.Name).BlobValue, MemoryBlock)
		        Else
		          p.Value(o) = row.Column(p.Name).NativeValue
		        End
		        
		      End
		      
		    End
		  Next
		  
		  Return o
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub FromDictionary(data as Dictionary, o as Object)
		  Using Introspection
		  
		  Var t As Introspection.TypeInfo = Introspection.GetType(o)
		  
		  For Each p As PropertyInfo In t.GetProperties
		    If p.IsPublic And p.CanWrite And Not p.IsComputed And Not JsonModelBase.HasAttribute(p, "#JsonIgnore") Then
		      
		      If data.HasKey(p.Name) Then
		        
		        If p.PropertyType.FullName = "String" Then
		          p.Value(o) = data.Value(p.Name).StringValue
		        ElseIf p.PropertyType.FullName = "DateTime" Then
		          p.Value(o) = data.Value(p.Name).DateTimeValue
		        ElseIf p.PropertyType.FullName = "Integer" Then
		          p.Value(o) = data.Value(p.Name).IntegerValue
		        ElseIf p.PropertyType.FullName = "Int32" Then
		          p.Value(o) = data.Value(p.Name).Int32Value
		        ElseIf p.PropertyType.FullName = "Int64" Then
		          p.Value(o) = data.Value(p.Name).Int64Value
		        ElseIf p.PropertyType.FullName = "Double" Then
		          p.Value(o) = data.Value(p.Name).DoubleValue
		        ElseIf p.PropertyType.FullName = "Single" Then
		          p.Value(o) = data.Value(p.Name).SingleValue
		        ElseIf p.PropertyType.FullName = "Currency" Then
		          p.Value(o) = data.Value(p.Name).CurrencyValue
		        ElseIf p.PropertyType.FullName = "Boolean" Then
		          p.Value(o) = data.Value(p.Name).BooleanValue
		        ElseIf p.PropertyType.FullName = "Picture" Then
		          If Not data.Value(p.Name).IsNull Then
		            Var pic As Picture = Picture.FromData(DecodeBase64(data.Value(p.Name).StringValue))
		            If pic <> Nil Then
		              p.Value(o) = pic
		            End
		          end
		        Else
		          If p.PropertyType.IsClass Then
		            Var cnstr() As ConstructorInfo = p.PropertyType.GetConstructors
		            Var instance As Variant = cnstr(0).Invoke
		            Var method As MethodInfo = JsonModelBase.GetMethod("FromDictionary", p.PropertyType.GetMethods())
		            Var params() As Variant
		            params.Add(data.Value(p.Name))
		            params.Add(instance)
		            method.Invoke(instance, params)
		            p.Value(o) = instance
		          ElseIf p.PropertyType.IsArray Then
		            Var x As Variant = CreateArray(p, data.Value(p.Name))
		            If x <> Nil Then
		              p.Value(o) = x
		            End
		          Else
		            p.Value(o) = data.Value(p.Name).ObjectValue
		          End
		        End
		        
		      End
		      
		    End
		  Next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub FromJson(json as String, o as Object)
		  Using Introspection
		  
		  Var data As Dictionary = ParseJSON(json)
		  
		  Var t As Introspection.TypeInfo = Introspection.GetType(o)
		  
		  For Each p As PropertyInfo In t.GetProperties
		    If p.IsPublic And p.CanWrite And Not p.IsComputed And Not JsonModelBase.HasAttribute(p, "#JsonIgnore") Then
		      
		      If data.HasKey(p.Name) And Not data.Value(p.Name).IsNull Then
		        
		        Select Case p.PropertyType.FullName
		          
		        Case "String"
		          p.Value(o) = data.Value(p.Name).StringValue
		          
		        Case  "DateTime"
		          p.Value(o) = data.Value(p.Name).DateTimeValue
		          
		        Case "Integer"
		          p.Value(o) = data.Value(p.Name).IntegerValue
		          
		        Case "Int32"
		          p.Value(o) = data.Value(p.Name).Int32Value
		          
		        Case "Int64"
		          p.Value(o) = data.Value(p.Name).Int64Value
		          
		        Case "Double"
		          p.Value(o) = data.Value(p.Name).DoubleValue
		          
		        Case "Single"
		          p.Value(o) = data.Value(p.Name).SingleValue
		          
		        Case "Currency"
		          p.Value(o) = data.Value(p.Name).CurrencyValue
		          
		        Case "Boolean"
		          p.Value(o) = data.Value(p.Name).BooleanValue
		          
		        Case "Picture"
		          Var pic As Picture = Picture.FromData(DecodeBase64(data.Value(p.Name).StringValue))
		          If pic <> Nil Then
		            p.Value(o) = pic
		          End
		          
		        Else
		          If p.PropertyType.IsPrimitive Then
		            p.Value(o) = data.Value(p.Name)
		          Else
		            Var js As New JSONItem(json) 
		            Var jsPart As JSONItem = js.Child(p.Name)
		            
		            If p.PropertyType.IsClass Then
		              Var cnstr() As ConstructorInfo = p.PropertyType.GetConstructors
		              Var instance As Variant = cnstr(0).Invoke
		              Var method As MethodInfo = JsonModelBase.GetMethod("FromJson", p.PropertyType.GetMethods())
		              Var params() As Variant
		              params.Add(jsPart.ToString)
		              params.Add(instance)
		              method.Invoke(instance, params)
		              p.Value(o) = instance
		            ElseIf p.PropertyType.IsArray Then
		              Var x As Variant = CreateArray(p, jsPart)
		              If x <> Nil Then
		                p.Value(o) = x
		              End
		            Else
		              p.Value(o) = data.Value(p.Name).ObjectValue
		            End
		          End
		        End
		        
		      End
		      
		    End
		  Next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function GetMethod(name as string, methods() as Introspection.MethodInfo) As Introspection.MethodInfo
		  Using Introspection
		  For Each mi As MethodInfo In methods
		    If mi.Name = name Then
		      Return mi
		    End
		  Next
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function HasAttribute(p as Introspection.PropertyInfo, name as string) As Boolean
		  Var attribs() As Introspection.AttributeInfo = p.GetAttributes
		  For Each a As Introspection.AttributeInfo In attribs
		    if a.Name = name then return True
		  Next
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToDictionary() As Dictionary
		  Using Introspection
		  
		  Var d As New Dictionary
		  
		  Var t As Introspection.TypeInfo = Introspection.GetType(Self)
		  
		  For Each p As PropertyInfo In t.GetProperties
		    
		    If p.IsPublic And p.CanRead And Not p.IsComputed Then
		      
		      If p.PropertyType.FullName = "Integer" Then
		        d.Value(p.Name) = p.Value(Self).IntegerValue
		        
		      ElseIf p.PropertyType.FullName = "Int32" Then
		        d.Value(p.Name) = p.Value(Self).Int32Value
		        
		      ElseIf p.PropertyType.FullName = "Int64" Then
		        d.Value(p.Name) = p.Value(Self).Int64Value
		        
		      ElseIf p.PropertyType.FullName = "Double" Then
		        d.Value(p.Name) = p.Value(Self).DoubleValue
		        
		      ElseIf p.PropertyType.FullName = "Single" Then
		        d.Value(p.Name) = p.Value(Self).SingleValue
		        
		      ElseIf p.PropertyType.FullName = "Currency" Then
		        d.Value(p.Name) = p.Value(Self).CurrencyValue
		        
		      Else
		        d.Value(p.Name) = DefineEncoding(p.Value(Self).StringValue, Encodings.UTF8)
		      End
		      
		    End
		    
		  Next
		  
		  Return d 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToJson(ignoreComplexTypes as Boolean = false) As JSONItem
		  Using Introspection
		  
		  Var json As New JSONItem
		  
		  Var t As Introspection.TypeInfo = Introspection.GetType(Self)
		  
		  For Each p As PropertyInfo In t.GetProperties
		    
		    If Not HasAttribute(p, "#JsonIgnore") Then
		      
		      If p.IsPublic And p.CanRead And Not p.IsComputed and not p.Value(self).IsNull Then
		        
		        If p.PropertyType.FullName = "Integer" Then
		          json.Value(p.Name) = p.Value(Self).IntegerValue
		          
		        ElseIf p.PropertyType.FullName = "Int32" Then
		          json.Value(p.Name) = p.Value(Self).Int32Value
		          
		        ElseIf p.PropertyType.FullName = "Int64" Then
		          json.Value(p.Name) = p.Value(Self).Int64Value
		          
		        ElseIf p.PropertyType.FullName = "Single" Then
		          json.Value(p.Name) = p.Value(Self).SingleValue
		          
		        ElseIf p.PropertyType.FullName = "Double" Then
		          json.Value(p.Name) = p.Value(Self).DoubleValue
		          
		        ElseIf p.PropertyType.FullName = "Currency" Then
		          json.Value(p.Name) = p.Value(Self).DoubleValue    // .CurrencyValue breaks JSONItem, XOJO bug?
		          
		        ElseIf p.PropertyType.FullName = "DateTime" Then
		          json.Value(p.Name) = p.Value(Self).DateTimeValue.SQLDateTime
		          
		        ElseIf p.PropertyType.FullName = "Boolean" Then
		          json.Value(p.Name) = p.Value(Self).BooleanValue.ToString
		          
		        ElseIf p.PropertyType.FullName = "String" Then
		          json.Value(p.Name) = p.Value(Self).StringValue
		          
		        ElseIf p.PropertyType.IsArray Then
		          json.Value(p.Name) = p.Value(Self)
		          
		        ElseIf p.PropertyType.FullName = "Picture" Then
		          Var pic As Picture = Picture(p.Value(Self))
		          If pic <> Nil Then
		            json.Value(p.Name) = EncodeBase64(pic.ToData(Picture.Formats.PNG), 0)
		          End
		          
		        ElseIf p.PropertyType.IsEnum Then
		          json.Value(p.Name) = p.Value(Self).IntegerValue
		          
		        Else
		          If Not ignoreComplexTypes Then
		            Var method As MethodInfo = JsonModelBase.GetMethod("ToJson", p.PropertyType.GetMethods())
		            If method <> Nil Then
		              
		              Var params() As Variant
		              params.Add(False)
		              Var o As JSONItem = method.Invoke(p.Value(Self), params)
		              json.Value(p.Name) = o
		            Else
		              If Not p.PropertyType.IsClass Then
		                json.Value(p.Name) = DefineEncoding(p.Value(Self).StringValue, Encodings.UTF8)
		              End
		            End
		          End
		        End
		        
		      End
		      
		    End
		    
		  Next
		  
		  If json.ToString = "" Then
		    // this may produce an exception with an usefull message if any type cannot be serialized properly
		  End
		  
		  Return json 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToJsonString(ignoreComplexTypes as Boolean = false) As string
		  Using Introspection
		  
		  Var json As New JSONItem
		  
		  Var t As Introspection.TypeInfo = Introspection.GetType(Self)
		  
		  For Each p As PropertyInfo In t.GetProperties
		    
		    If Not HasAttribute(p, "#JsonIgnore") Then
		      
		      If p.IsPublic And p.CanRead And Not p.IsComputed and not p.Value(self).IsNull Then
		        
		        If p.PropertyType.FullName = "Integer" Then
		          json.Value(p.Name) = p.Value(Self).IntegerValue
		          
		        ElseIf p.PropertyType.FullName = "Int32" Then
		          json.Value(p.Name) = p.Value(Self).Int32Value
		          
		        ElseIf p.PropertyType.FullName = "Int64" Then
		          json.Value(p.Name) = p.Value(Self).Int64Value
		          
		        ElseIf p.PropertyType.FullName = "Single" Then
		          json.Value(p.Name) = p.Value(Self).SingleValue
		          
		        ElseIf p.PropertyType.FullName = "Double" Then
		          json.Value(p.Name) = p.Value(Self).DoubleValue
		          
		        ElseIf p.PropertyType.FullName = "Currency" Then
		          json.Value(p.Name) = p.Value(Self).CurrencyValue
		          
		        ElseIf p.PropertyType.FullName = "DateTime" Then
		          json.Value(p.Name) = p.Value(Self).DateTimeValue.SQLDateTime
		          
		        ElseIf p.PropertyType.FullName = "Boolean" Then
		          json.Value(p.Name) = p.Value(Self).BooleanValue.ToString
		          
		        ElseIf p.PropertyType.FullName = "String" Then
		          json.Value(p.Name) = p.Value(Self).StringValue
		          
		        Else
		          If Not ignoreComplexTypes Then
		            json.Value(p.Name) = DefineEncoding(p.Value(Self).StringValue, Encodings.UTF8)
		          End
		        End
		        
		      End
		      
		    End
		    
		  Next
		  
		  Return json.ToString 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToVariantArray() As Variant()
		  Using Introspection
		  
		  Var d() As Variant
		  
		  Var t As Introspection.TypeInfo = Introspection.GetType(Self)
		  
		  For Each p As PropertyInfo In t.GetProperties
		    
		    If p.IsPublic And p.CanRead And Not p.IsComputed Then
		      d.Add(p.Value(Self))
		    End
		    
		  Next
		  
		  Return d 
		End Function
	#tag EndMethod


	#tag Note, Name = History
		v1.1.9 - 2024-03-28
		-------------------
		- ToJson Unterstützung für Enums
		
		v1.1.12 - 2025-05-19
		--------------------
		- Unterstützung für Fließkommazahlen (Single, Double, Currency)
		
		v1.2.0 - 2025-05-21
		--------------------
		- Rekursive Serialisieung und Deserialisierung von ToJson() und FromJson(), auch mit komplexen Typen/Classen
		
		v1.2.4 - 2025-10-08
		--------------------
		- FromDictionary rekursiv und Picture
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
End Class
#tag EndClass
