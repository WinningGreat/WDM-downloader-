#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_UseUpx=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <WinAPIShPath.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <WindowsConstants.au3>
#include <InetConstants.au3>
#include <ProgressConstants.au3>
#include <WDM download Dialog.au3>
#include <WDM(EmptyInput).au3>
#include <WDMBrowseFolder.au3>
#include <GUIListView.au3>
#include <bbb.au3>

Opt("GUIOnEventMode", 1)
$Form1 = GUICreate("WDM(downloader)", 684, 482, 199, 25, BitOR($WS_MINIMIZEBOX, $WS_SYSMENU, $WS_GROUP, $WS_HSCROLL, $WS_VSCROLL), BitOR($WS_EX_LEFTSCROLLBAR, $WS_EX_WINDOWEDGE))
GUISetOnEvent($GUI_EVENT_CLOSE, "SpecialEvents")
GUISetOnEvent($GUI_EVENT_MINIMIZE, "SpecialEvents")
GUISetOnEvent($GUI_EVENT_RESTORE, "SpecialEvents")






$Tab1 = GUICtrlCreateTab(8, 96, 657, 385)
GUICtrlSetFont(-1, 10, 800, 0, "Bell MT")



$DownloadTab = GUICtrlCreateTabItem("Downloads")



$btnPause = GUICtrlCreateButton("| |", 84, 128, 49, 25)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")




$FileSize = ''
$btnStart = GUICtrlCreateButton("|>", 140, 128, 49, 25)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetOnEvent(-1, "btnStartPressed")


$btnAddUrl = GUICtrlCreateButton("+", 30, 129, 49, 25)
GUICtrlSetFont(-1, 15, 800, 0, "MS Sans Serif")
GUICtrlSetOnEvent(-1, "btnAddUrlPressed")

$LabelAddUrl = GUICtrlCreateLabel("Add Download URL", 12, 168, 115, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0x008000)
GUICtrlSetState(-1, $GUI_HIDE)


$oldUrlInput = ""
$InputUrl = GUICtrlCreateInput("input your download address here!!!!", 132, 168, 441, 21)
GUICtrlSetTip(-1, "input your download address here")
GUICtrlSetState(-1, $GUI_HIDE)

$LabelFolder = GUICtrlCreateLabel("Folder", 16, 200, 39, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0x008000)
GUICtrlSetState(-1, $GUI_HIDE)


$oldFolderInput = ""
$InputFolder = GUICtrlCreateInput($oldFolderInput, 64, 192, 401, 21)
GUICtrlSetState(-1, $GUI_HIDE)

$btnBrowseFolder = GUICtrlCreateButton("Browse", 472, 192, 57, 25)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetOnEvent(-1, "btnBrowseFolderPressed")

$LabelFileName = GUICtrlCreateLabel("File Name", 16, 232, 60, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0x008000)
GUICtrlSetState(-1, $GUI_HIDE)
$InputFileName = GUICtrlCreateInput("", 84, 232, 209, 21)
GUICtrlSetState(-1, $GUI_HIDE)

$btnDefaultFileName = GUICtrlCreateButton("Get Default ", 296, 232, 81, 25) ; get default file name
GUICtrlSetFont(-1, 10, 800, 0, "Bell MT")  ; get default file name
GUICtrlSetOnEvent(-1, "btnDefaultFileNamePressed")
GUICtrlSetState(-1, $GUI_HIDE)

$displayStatus = ''
$displayLabel = GUICtrlCreateLabel($displayStatus, 16, 232, 60, 17)
GUICtrlSetState($displayLabel, $GUI_HIDE)



$ListAllTab = GUICtrlCreateTabItem("Current")
$List1 = GUICtrlCreateList("", 16, 128, 633, 329)
GUICtrlSetFont(-1, 10, 800, 0, "Bell MT")
Example($ListAllTab)


$Settings = GUICtrlCreateTabItem("Settings")
GUICtrlCreateTabItem("")
GUISetState(@SW_SHOW)


DirCreate(@UserProfileDir & "\Downloads\WDM")

$numOfDownloadSignature = 0
$numOfDownloadsLabel = GUICtrlCreateLabel($numOfDownloadSignature, 16, 232, 60, 17)
GUICtrlSetState($numOfDownloadsLabel, $GUI_HIDE)




While 1
	Sleep(10)
WEnd

Func btnAddUrlPressed()

	GUICtrlSetState($btnBrowseFolder, $GUI_SHOW)
	GUICtrlSetState($btnAddUrl, $GUI_SHOW)
	GUICtrlSetState($InputFolder, $GUI_SHOW)
	GUICtrlSetState($InputUrl, $GUI_SHOW)
	GUICtrlSetState($LabelAddUrl, $GUI_SHOW)
	GUICtrlSetState($LabelFolder, $GUI_SHOW)
	GUICtrlSetState($LabelFileName, $GUI_SHOW)
	GUICtrlSetState($InputFileName, $GUI_SHOW)
	GUICtrlSetState($btnDefaultFileName,$GUI_SHOW)
	$displayStatus = 1
	GUICtrlSetData($displayLabel, $displayStatus)
	GUICtrlSetData($InputFileName, "")
	GUICtrlSetData($InputUrl, "")


EndFunc   ;==>btnAddUrlPressed



Func btnBrowseFolderPressed()
	_btnBrowse($InputFolder, $oldFolderInput)
	$displayStatus = 1
	GUICtrlSetData($displayLabel, $displayStatus)

		$oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
	$sFileUrl = GUICtrlRead($InputUrl)
	$sFileUrlOriginal = GUICtrlRead($InputUrl)
	$oHTTP.Open("HEAD", $sFileUrl, False)
	$oHTTP.Send()
	$oStatusCode = $oHTTP.Status
	$oStatusText = $oHTTP.StatusText
	$oHeaders = $oHTTP.GetAllResponseHeaders()

	If  200<= $oStatusCode<=299 Then
		$statusFile = FileOpen(GUICtrlRead($InputFolder) & "\" & "status.txt", 2)
		FileWrite($statusFile, $oHeaders & @CRLF & $oStatusText & @CRLF & $oStatusCode)
		FileClose($statusFile)
		If StringLen(_WinAPI_UrlGetPart($sFileUrl, $URL_PART_QUERY)) > 0 Then
			$i = StringLen(_WinAPI_UrlGetPart($sFileUrl, $URL_PART_QUERY))
			$Filename = _WinAPI_PathFindFileName(StringTrimRight($sFileUrl, $i + 1))
			ConsoleWrite($i & @CRLF)
			GUICtrlSetData($InputFileName,$Filename)
		ElseIf StringLen(_WinAPI_UrlGetPart($sFileUrl, $URL_PART_QUERY)) = 0 Then
			$sFileUrl = $sFileUrl
			$nameExtension = _WinAPI_PathFindExtension($sFileUrl)
			$Filename = _WinAPI_PathFindFileName($sFileUrl)
			FileClose($statusFile)
			GUICtrlSetData($InputFileName,$Filename)

		EndIf

	Endif


EndFunc   ;==>btnBrowseFolderPressed

Func btnStartPressed()
	If GUICtrlRead($InputUrl) = "" Or  GUICtrlRead($InputFolder) = "" Or GUICtrlRead($displayLabel) = 0 or GUICtrlRead($InputFileName) = "" Then
		_emptyInputs($btnAddUrl, $btnBrowseFolder, $displayLabel, $displayStatus, $InputFileName, $InputFolder, $InputUrl, $LabelAddUrl, $LabelFileName, $LabelFolder, $GUI_SHOW,$btnDefaultFileName)
	Else

			_downloadStarted($InputFileName, $InputFolder, $InputUrl,$Form1)


EndIf




EndFunc   ;==>btnStartPressed

Func btnDefaultFileNamePressed()

		If GUICtrlRead($InputUrl) = "" Then
			MsgBox(0,"???","input a valid url")
			Else
	$oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
	$sFileUrl = GUICtrlRead($InputUrl)
	$sFileUrlOriginal = GUICtrlRead($InputUrl)
	$oHTTP.Open("HEAD", $sFileUrl, False)
	$oHTTP.Send()
	$oStatusCode = $oHTTP.Status
	$oStatusText = $oHTTP.StatusText
	$oHeaders = $oHTTP.GetAllResponseHeaders()

	If  200<= $oStatusCode<=299 Then
		$statusFile = FileOpen($InputFolder & "\" & "status.txt", 2)
		FileWrite($statusFile, $oHeaders & @CRLF & $oStatusText & @CRLF & $oStatusCode)
		FileClose($statusFile)
		If StringLen(_WinAPI_UrlGetPart($sFileUrl, $URL_PART_QUERY)) > 0 Then
			$i = StringLen(_WinAPI_UrlGetPart($sFileUrl, $URL_PART_QUERY))
			$Filename = _WinAPI_PathFindFileName(StringTrimRight($sFileUrl, $i + 1))
			ConsoleWrite($i & @CRLF)
			GUICtrlSetData($InputFileName,$Filename)
		ElseIf StringLen(_WinAPI_UrlGetPart($sFileUrl, $URL_PART_QUERY)) = 0 Then
			$sFileUrl = $sFileUrl
			$nameExtension = _WinAPI_PathFindExtension($sFileUrl)
			$Filename = _WinAPI_PathFindFileName($sFileUrl)
			FileClose($statusFile)
			GUICtrlSetData($InputFileName,$Filename)
		EndIf
		Else
			GUICtrlSetData($InputFileName,"Couldn't retrieve the default file name--"&@CRLF&"make sure the url is valid")


	EndIf
	Endif

	EndFunc






Func SpecialEvents()
	Select
		Case @GUI_CtrlId = $GUI_EVENT_CLOSE

			Exit

		Case @GUI_CtrlId = $GUI_EVENT_MINIMIZE


		Case @GUI_CtrlId = $GUI_EVENT_RESTORE


	EndSelect
EndFunc   ;==>SpecialEvents













