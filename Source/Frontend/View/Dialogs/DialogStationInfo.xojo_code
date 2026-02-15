#tag WebPage
Begin WebDialog DialogStationInfo
   Compatibility   =   ""
   ControlCount    =   0
   ControlID       =   ""
   CSSClasses      =   ""
   Enabled         =   True
   Height          =   600
   Index           =   -2147483648
   Indicator       =   0
   LayoutDirection =   0
   LayoutType      =   0
   Left            =   0
   LockBottom      =   False
   LockHorizontal  =   False
   LockLeft        =   False
   LockRight       =   False
   LockTop         =   False
   LockVertical    =   False
   PanelIndex      =   0
   Position        =   0
   TabIndex        =   0
   Top             =   0
   Visible         =   True
   Width           =   800
   _mDesignHeight  =   0
   _mDesignWidth   =   0
   _mPanelIndex    =   -1
   Begin WebHTMLViewer HTMLViewer1
      ControlID       =   ""
      CSSClasses      =   ""
      Enabled         =   True
      Height          =   540
      Index           =   -2147483648
      Indicator       =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   1
      UseSandbox      =   True
      Visible         =   True
      Width           =   798
      _mPanelIndex    =   -1
   End
   Begin WebButton btnOk
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "OK"
      ControlID       =   ""
      CSSClasses      =   ""
      Default         =   True
      Enabled         =   True
      Height          =   30
      Index           =   -2147483648
      Indicator       =   1
      Left            =   40
      LockBottom      =   True
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      LockVertical    =   False
      Outlined        =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   1
      TabStop         =   True
      Tooltip         =   ""
      Top             =   555
      Visible         =   True
      Width           =   100
      _mPanelIndex    =   -1
   End
   Begin WebRectangle Rectangle1
      BackgroundColor =   &cFFFFFF
      BorderColor     =   &cEBEBEB00
      BorderThickness =   1
      ControlCount    =   0
      ControlID       =   ""
      CornerSize      =   -1
      CSSClasses      =   ""
      Enabled         =   True
      HasBackgroundColor=   False
      Height          =   1
      Index           =   -2147483648
      Indicator       =   ""
      LayoutDirection =   "LayoutDirections.LeftToRight"
      LayoutType      =   "LayoutTypes.Fixed"
      Left            =   1
      LockBottom      =   True
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      LockVertical    =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   2
      TabStop         =   True
      Tooltip         =   ""
      Top             =   540
      Visible         =   True
      Width           =   797
      _mDesignHeight  =   0
      _mDesignWidth   =   0
      _mPanelIndex    =   -1
   End
   Begin WebButton btnPrint
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "Drucken"
      ControlID       =   ""
      CSSClasses      =   "border-0"
      Default         =   False
      Enabled         =   True
      Height          =   30
      Index           =   -2147483648
      Indicator       =   0
      Left            =   660
      LockBottom      =   True
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      LockVertical    =   False
      Outlined        =   True
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   3
      TabStop         =   True
      Tooltip         =   "#kTooltipPrintStationInfo"
      Top             =   555
      Visible         =   True
      Width           =   100
      _mPanelIndex    =   -1
   End
   Begin WebButton btnLogo8Export
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "LOGO8 CSV"
      ControlID       =   ""
      CSSClasses      =   "border-0"
      Default         =   False
      Enabled         =   True
      Height          =   30
      Index           =   -2147483648
      Indicator       =   0
      Left            =   520
      LockBottom      =   True
      LockedInPosition=   True
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      LockVertical    =   False
      Outlined        =   True
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   4
      TabStop         =   True
      Tooltip         =   "#kTooltipLOGO8CSV"
      Top             =   555
      Visible         =   True
      Width           =   130
      _mPanelIndex    =   -1
   End
End
#tag EndWebPage

#tag WindowCode
	#tag Method, Flags = &h21
		Private Function Logo8CompoTypeMapper(ct as Enums.ComponentTypes, i as integer) As string
		  Select Case ct
		    
		  Case Enums.ComponentTypes.Sensor
		  Case Enums.ComponentTypes.FillLevel
		    Return "AM,Word," + Str(i)+ ",1,True,60,False,False"
		    
		  Else
		    Return "M,Bit," + Str(i)+ ",1,True,60,True,True"
		    
		  End
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Logo8Export()
		  Var index As Integer
		  Var lines() As String
		  lines.Add(kLogo8CsvExportHeader)
		  
		  For Each c As ComponentModel In MyStation.Components
		    If c.TypeDef <> Enums.ComponentTypes.Divider And _
		      c.TypeDef <> Enums.ComponentTypes.Counter Then  
		      Var elems() As String
		      elems.Add(c.HardwareId)
		      elems.add(Logo8CompoTypeMapper(c.TypeDef, index))
		      lines.Add(String.FromArray(elems, ","))
		      index = index + 1
		    End
		  Next
		  
		  ExportFile = New WebFile
		  ExportFile.Data = String.FromArray(lines, EndOfLine)
		  ExportFile.MIMEType = "text/csv"
		  ExportFile.ForceDownload = True
		  ExportFile.Filename = MyStation.ShortName + ".csv"
		  GoToURL(ExportFile.URL, True)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Show(station as StationModel)
		  // Calling the overridden superclass method.
		  Super.Show()
		  MyStation = station
		  ShowStationInfo()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowStationInfo()
		  Var docuSvc As New DocumentationService
		  HtmlContent = docuSvc.CreateHtmlDocu(MyStation)
		  HTMLViewer1.LoadHTML(HtmlContent)
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = LOGO8 Export
		
		Name,Bereich,Typ,Adresse,Länge,Mit einer Frequenz,Zeitraum (t:s:m:s),Bei Änderung,Schreibbar
		Q3DCMDNFEH,M,Bit,0,1,True,60,False,False
		FP8K1CFN6A,AM,Word,0,1,True,10,False,False
		ZQAPKZGYRG,I,Bit,2,1,True,10,True,False
		3ZRHU82R9M,Q,Bit,0,1,True,10,False,True
		R3Q77MYLTF,AM,Word,1,4,true,10,false,false
	#tag EndNote


	#tag Property, Flags = &h21
		Private ExportFile As WebFile
	#tag EndProperty

	#tag Property, Flags = &h21
		Private HtmlContent As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private MyStation As StationModel
	#tag EndProperty


	#tag Constant, Name = kHtmlPrintTemplate, Type = String, Dynamic = False, Default = \"<!DOCTYPE html>\n<html>\n<head>\n<meta charset\x3D\"utf-8\">\n<style>\nbody { font-family: Roboto\x2C-apple-system\x2CSegoe UI\x2CHelvetica Neue\x2CArial\x2Csans-serif; margin-left: 3em; margin-right: 2em; }\n#footer { position: fixed; bottom: 1em; margin-left: 3em; z-index: -1; width: calc(100% - 3em); font-size: 0.8em; color: #666; }\n#content { background-color: white; }\n</style>\n</head>\n<body>\n<div id\x3D\"content\">\n{content}\n</div>\n<div id\x3D\"footer\">\n{footer}\n</div>\n</body>\n</html>", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kLogo8CsvExportHeader, Type = String, Dynamic = False, Default = \"Name\x2CBereich\x2CTyp\x2CAdresse\x2CL\xC3\xA4nge\x2CMit einer Frequenz\x2CZeitraum (t:s:m:s)\x2CBei \xC3\x84nderung\x2CSchreibbar", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTooltipLOGO8CSV, Type = String, Dynamic = True, Default = \"Erzeugt eine Datei f\xC3\xBCr den Import der LOGO8 Cloud-Datenverbindung. HINWEIS: Der Browser muss Popup Fenster erlauben!", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTooltipPrintStationInfo, Type = String, Dynamic = True, Default = \"Zeigt die Stationsdaten als neuen Browser-Tab an. Dieser kann \xC3\xBCber den Browser gedruckt werden. HINWEIS: Im Browser m\xC3\xBCssen Popup Fenster erlaubt sein!", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events btnOk
	#tag Event
		Sub Pressed()
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnPrint
	#tag Event
		Sub Pressed()
		  ExportFile = New WebFile
		  ExportFile.Data = kHtmlPrintTemplate.Replace("{content}", HtmlContent).Replace("{footer}", app.AppCopyrightText)
		  ExportFile.MIMEType = "text/html"
		  GoToURL(ExportFile.URL, True)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnLogo8Export
	#tag Event
		Sub Pressed()
		  Logo8Export
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="PanelIndex"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Index"
		Visible=false
		Group="ID"
		InitialValue="-2147483648"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
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
	#tag ViewProperty
		Name="Position"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="WebDialog.Positions"
		EditorType="Enum"
		#tag EnumValues
			"0 - Top"
			"1 - Center"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="ControlCount"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_mPanelIndex"
		Visible=false
		Group="Behavior"
		InitialValue="-1"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ControlID"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Enabled"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Behavior"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LayoutType"
		Visible=true
		Group="Behavior"
		InitialValue="LayoutTypes.Fixed"
		Type="LayoutTypes"
		EditorType="Enum"
		#tag EnumValues
			"0 - Fixed"
			"1 - Flex"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockHorizontal"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockVertical"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Behavior"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_mDesignHeight"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_mDesignWidth"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_mName"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIndex"
		Visible=true
		Group="Visual Controls"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Indicator"
		Visible=false
		Group="Visual Controls"
		InitialValue=""
		Type="WebUIControl.Indicators"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Primary"
			"2 - Secondary"
			"3 - Success"
			"4 - Danger"
			"5 - Warning"
			"6 - Info"
			"7 - Light"
			"8 - Dark"
			"9 - Link"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="LayoutDirection"
		Visible=true
		Group="WebView"
		InitialValue="LayoutDirections.LeftToRight"
		Type="LayoutDirections"
		EditorType="Enum"
		#tag EnumValues
			"0 - LeftToRight"
			"1 - RightToLeft"
			"2 - TopToBottom"
			"3 - BottomToTop"
		#tag EndEnumValues
	#tag EndViewProperty
#tag EndViewBehavior
