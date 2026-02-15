#tag Class
Protected Class DocumentationService
	#tag Method, Flags = &h0
		Function CreateHtmlDocu(station as StationModel) As string
		  Var stationInfoHtml As String = kStationHtmlStationInfo _
		  .Replace("{DisplayName}", station.DisplayName)_
		  .Replace("{ShortName}", station.ShortName)_
		  .Replace("{Uid}", station.Uid)_
		  .Replace("{Type}", station.TypeName)_
		  .Replace("{Latitude}", Str(station.Location.Latitude))_
		  .Replace("{Longitude}", Str(station.Location.Longitude))
		  
		  Var componentInfoHtml() As String
		  Var rowCnt As Integer = 0
		  For Each component As ComponentModel In station.Components
		    If component.TypeDef <> Enums.ComponentTypes.Divider Then
		      componentInfoHtml.Add(kStationHtmlCoomponentInfo _
		      .Replace("{DisplayName}", component.DisplayName)_
		      .Replace("{ShortName}", component.ShortName)_
		      .Replace("{HardwareId}", component.HardwareId)_
		      .Replace("{MinValue}", Str(component.MinValue))_
		      .Replace("{MaxValue}", Str(component.MaxValue))_
		      .Replace("{DisplayUnit}", component.DisplayUnit)_
		      .Replace("{Type}", component.TypeName)_
		      .Replace("{class}", If((rowCnt Mod 2) = 0, "alt-row", "")))
		      rowcnt = rowCnt + 1
		    End
		  Next
		  
		  Var html As String = kStationHtmlDocuBody _
		  .Replace("{station}", stationInfoHtml)_
		  .Replace("{components}", String.FromArray(componentInfoHtml, EndOfLine))
		  
		  Return html
		End Function
	#tag EndMethod


	#tag Constant, Name = kStationHtmlCoomponentInfo, Type = String, Dynamic = False, Default = \"<tr class\x3D\"{class}\"><td>{DisplayName}</td><td>{ShortName}</td><td>{Type}</td><td>{HardwareId}</td><td>{MinValue}</td><td>{MaxValue}</td><td>{DisplayUnit}</td></tr>", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kStationHtmlDocuBody, Type = String, Dynamic = False, Default = \"<style>\ntable\x2C tr\x2C th { padding: 0; margin: 0; border-spacing: 0; }\nth { text-align: start; }\ntd\x2C th { padding: 6px 20px 6px 8px; }\ntr { border-top: solid 1px #ddd; }\nh2 { font-size: 1.4em; }\nh3 { font-size: 1.15em; }\n.alt-row { background-color: #f8f8f8; }\n.pad { padding: 5px 5px; }\n.small { font-size: 0.85em; }\n.pale { color: #666; }\n.w100 { width: 100px; display: inline-block; }\n#main { margin: 2em 3em; font-size: 0.9em; }\n#components { overflow: hidden; }\n</style>\n<div id\x3D\"main\">\n<div id\x3D\"station\">\n{station}\n</div>\n<div id\x3D\"components\">\n<h3>Komponenten</h3>\n<table>\n<tr><th>Name</th><th>Kurzname</th><th>Typ</th><th>Hardware-ID</th><th>Min.</th><th>Max.</th><th>Einheit</th></tr>\n{components}\n</table>\n</div>\n</div>\n", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kStationHtmlStationInfo, Type = String, Dynamic = False, Default = \"<h2>{DisplayName}</h2>\n<div class\x3D\"pad\">Stationseigenschaften und zugeh\xC3\xB6rige Komponenten.</div>\n<div class\x3D\"pad\">\n<div><span class\x3D\"pale small w100\">Kurzname: &nbsp; </span>{ShortName}</div>\n<div><span class\x3D\"pale small w100\">Uid: &nbsp; </span>{Uid}</div>\n<div><span class\x3D\"pale small w100\">Lokation: &nbsp; </span>{Latitude} / {Longitude}</div>\n<div><span class\x3D\"pale small w100\">Typ: &nbsp; </span>{Type}</div>\n</div>\n&nbsp;", Scope = Private
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
End Class
#tag EndClass
