#include <WinAPIShPath.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <WindowsConstants.au3>
#include <InetConstants.au3>
#include <ProgressConstants.au3>


Opt("GUIOnEventMode", 1)



#Region ### START Koda GUI section ### Form=

$Form1 = GUICreate("WDM(downloader)", 684, 482, 199, 25, BitOR($WS_MINIMIZEBOX,$WS_SYSMENU,$WS_GROUP,$WS_HSCROLL,$WS_VSCROLL), BitOR($WS_EX_LEFTSCROLLBAR,$WS_EX_WINDOWEDGE))
GUISetOnEvent($GUI_EVENT_CLOSE, "CLOSEButton")

$Tab1 = GUICtrlCreateTab(8, 96, 657, 385, BitOR($TCS_FLATBUTTONS,$WS_VSCROLL))
GUICtrlSetFont(-1, 8, 400, 0, "Baskerville Old Face")
$TabSheet1 = GUICtrlCreateTabItem("TabSheet1")



$btnPause = GUICtrlCreateButton("| |", 84, 128, 49, 25)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")


$FileSize = ''
$btnStart = GUICtrlCreateButton("|>", 140, 128, 49, 25)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetOnEvent($btnStart,"_Start")


$btnAddUrl = GUICtrlCreateButton("+", 30, 129, 49, 25)
GUICtrlSetFont(-1, 15, 800, 0, "MS Sans Serif")
GUICtrlSetOnEvent($btnAddUrl,"_AddUrl")

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
GUICtrlSetOnEvent($btnBrowseFolder,"_browseFolder")

$LabelFileName = GUICtrlCreateLabel("File Name", 16, 232, 60, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0x008000)
GUICtrlSetState(-1, $GUI_HIDE)
$InputFileName = GUICtrlCreateInput("", 84, 232, 209, 21)
GUICtrlSetState(-1,$GUI_HIDE)

$displayStatus = ''
$displayLabel = GUICtrlCreateLabel($displayStatus, 16, 232, 60, 17)
GUICtrlSetState($displayLabel,$GUI_HIDE)


$TabSheet2 = GUICtrlCreateTabItem("TabSheet2")
$TabSheet3 = GUICtrlCreateTabItem("TabSheet3")
GUICtrlCreateTabItem("")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

DirCreate(@UserProfileDir&"\Downloads\WDM")
DirCreate(@UserProfileDir&"\Downloads\WDM\Videos")
DirCreate(@UserProfileDir&"\Downloads\WDM\Documents")
DirCreate(@UserProfileDir&"\Downloads\WDM\Programs")
DirCreate(@UserProfileDir&"\Downloads\WDM\Compressed")
DirCreate(@UserProfileDir&"\Downloads\WDM\Others")

$numOfDownloadSignature = 0
$numOfDownloadsLabel = GUICtrlCreateLabel($numOfDownloadSignature, 16, 232, 60, 17)
GUICtrlSetState($numOfDownloadsLabel,$GUI_HIDE)


While 1
	Sleep(100)
	WEnd

Func _AddUrl()
			GUICtrlSetState($btnBrowseFolder, $GUI_SHOW)
			GUICtrlSetState($btnAddUrl,$GUI_SHOW)
			GUICtrlSetState($InputFolder,$GUI_SHOW)
			GUICtrlSetState($InputUrl,$GUI_SHOW)
			GUICtrlSetState($LabelAddUrl,$GUI_SHOW)
			GUICtrlSetState($LabelFolder,$GUI_SHOW)
			GUICtrlSetState($LabelFileName, $GUI_SHOW)
			GUICtrlSetState($InputFileName, $GUI_SHOW)
			$displayStatus = 1
			GUICtrlSetData($displayLabel,$displayStatus)
			GUICtrlSetData($InputFileName,"")
			GUICtrlSetData($InputUrl,"")
			EndFunc



		Func _browseFolder()
			$displayStatus = 1
			GUICtrlSetData($displayLabel,$displayStatus)
			$oldFolderInput = FileSelectFolder("Select Download Folder","",0,GUICtrlRead($InputFolder))
			GUICtrlSetData($InputFolder,$oldFolderInput)
			EndFunc


		Func _Start()
			If GUICtrlRead($InputUrl) = "" or GUICtrlRead($InputFileName) = "" or GUICtrlRead($InputFolder) = "" or GUICtrlRead($displayLabel) = 0 Then
				GUICtrlSetState($btnBrowseFolder, $GUI_SHOW)
			GUICtrlSetState($btnAddUrl,$GUI_SHOW)
			GUICtrlSetState($InputFolder,$GUI_SHOW)
			GUICtrlSetState($InputUrl,$GUI_SHOW)
			GUICtrlSetState($LabelAddUrl,$GUI_SHOW)
			GUICtrlSetState($LabelFolder,$GUI_SHOW)
			GUICtrlSetState($LabelFileName, $GUI_SHOW)
			GUICtrlSetState($InputFileName, $GUI_SHOW)
			$displayStatus = 1
			GUICtrlSetData($displayLabel,$displayStatus)
			MsgBox(0,"??Empty Url String/FileName/Folder","Enter a valid Url/FileName/Folder")


			Else

			Opt("GUIOnEventMode", 1)
	$FileDownloadProgress = GUICreate("Downloading "&GUICtrlRead($InputFileName), 470, 312, 244, 147, BitOR($WS_MINIMIZEBOX,$WS_SIZEBOX,$WS_THICKFRAME,$WS_SYSMENU,$WS_GROUP))
	GUISetOnEvent($GUI_EVENT_CLOSE,"CLOSEButton")




$_LabelFileName = GUICtrlCreateLabel("File Name", 8, 24, 60, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0x008000)
$_oldFileName = ""
$_FileName = GUICtrlCreateLabel("", 80, 24, 308, 17)



$_LabelDownloadSize = GUICtrlCreateLabel("Download Size", 8, 72, 88, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0x008000)
$_oldDownloadSize_mb = ""
$_DownloadSize_mb = GUICtrlCreateLabel("",104, 72, 156, 17)

$_LabelDownloadProgress = GUICtrlCreateLabel("Download Progress", 8, 120, 113, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0x008000)
$_oldDownloadProgress = ""
$_DownloadProgress = GUICtrlCreateLabel("", 48, 168, 316, 25)


$Progress1 = GUICtrlCreateProgress(32, 144, 393, 17)
$_LabelFileLocation = GUICtrlCreateLabel("File Location", 8, 192, 77, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0x008000)
$_oldFileLocation = ""
$_FileLocation = GUICtrlCreateLabel("", 32, 212, 228, 17)

$_oldisDownloadSpeed = 0
$_isDownloadSpeed = GUICtrlCreateLabel($_oldisDownloadSpeed&" kb/s", 140, 119, 204, 20)

$_oldTimeLeftHrs = ''
$_oldTimeLeftMins = ''
$_oldTimeLeftSecs = ''
$_timeLeft = GUICtrlCreateLabel($_oldTimeLeftHrs&$_oldTimeLeftMins&$_oldTimeLeftSecs&" left", 84, 236, 356, 12)
$_timeLeftHidden = GUICtrlCreateLabel($_oldTimeLeftSecs, 128, 240, 228, 20)
GUICtrlSetState(-1,$GUI_HIDE)

$_btnStart = GUICtrlCreateButton("Start/Resume", 8, 261, 81, 25)
GUICtrlSetFont(-1, 8, 800, 4, "MS Sans Serif")
GUICtrlSetColor(-1, 0x008000)
GUICtrlSetTip(-1, "click to start download")
GUICtrlSetOnEvent($_btnStart,"downloadStart")


$_btnPause = GUICtrlCreateButton("Pause", 112, 261, 49, 25)
GUICtrlSetFont(-1, 8, 800, 4, "MS Sans Serif")
GUICtrlSetColor(-1, 0x008000)
GUICtrlSetTip(-1, "click to pause download")
GUICtrlSetOnEvent($_btnPause,"_Pause")




$_btnCancel = GUICtrlCreateButton("Cancel", 160, 261, 57, 25)
GUICtrlSetFont(-1, 8, 800, 4, "MS Sans Serif")
GUICtrlSetColor(-1, 0x008000)
GUICtrlSetTip(-1, "click to cancel download")
GUICtrlSetOnEvent($_btnCancel,"_Cancel")
GUISetState(@SW_SHOW)

$displayStatusForDownloadDialog = 1



$FileSize = InetGetSize(GUICtrlRead($InputUrl))


			$_oldFileName = GUICtrlRead($InputFileName)
			GUICtrlSetData($_FileName,$_oldFileName)



			$_oldFileLocation = GUICtrlRead($InputFolder)
			GUICtrlSetData($_FileLocation,$_oldFileLocation)


Func downloadStart()

			Global $hdownload = InetGet(GUICtrlRead($InputUrl),GUICtrlRead($InputFolder)&"\"&GUICtrlRead($InputFileName),$INET_FORCERELOAD,$INET_DOWNLOADBACKGROUND)
		Global $FileSizeDownloaded = InetGetInfo($hdownload,$INET_DOWNLOADREAD)
		Global	$FileDownloadStatus = InetGetinfo($hdownload,$INET_DOWNLOADCOMPLETE)
			Global $isDownloadSuccess =  InetGetInfo($hdownload,$INET_DOWNLOADSUCCESS)
			Global $percentDownloaded = (InetGetInfo($hdownload,$INET_DOWNLOADREAD)/InetGetInfo($hdownload,$INET_DOWNLOADSIZE))*100
			Global $isDownloadSize = InetGetInfo($hdownload,$INET_DOWNLOADSIZE)


	Do
				$idMsg = GUIGetMsg()


			For $i = $percentDownloaded To 100
					$percentDownloaded = (InetGetInfo($hdownload,$INET_DOWNLOADREAD)/InetGetInfo($hdownload,$INET_DOWNLOADSIZE))*100
					$_oldDownloadProgress = "Downloaded "&$percentDownloaded&"% "&"of "&100&"%"
					$_oldDownloadSize_mb = StringTrimRight((InetGetInfo($hdownload,$INET_DOWNLOADREAD)*(9.53e-007)),7)&"/"&StringTrimRight(($FileSize*(9.53e-007)),7)&" mb"
					GUICtrlSetData($_DownloadSize_mb,$_oldDownloadSize_mb)
					GUICtrlSetData($_DownloadProgress,$_oldDownloadProgress)
					GUICtrlSetData($Progress1,$percentDownloaded)
					$j = InetGetInfo($hdownload,$INET_DOWNLOADREAD)
					Sleep(100)
					$i = InetGetInfo($hdownload,$INET_DOWNLOADREAD)
					$_oldisDownloadSpeed = ((($i-$j)*(9.8e-004))/(0.1))

					$x = ((InetGetInfo($hdownload,$INET_DOWNLOADSIZE)*(9.8e-004))-(InetGetInfo($hdownload,$INET_DOWNLOADREAD)*(9.8e-004)))/$_oldisDownloadSpeed
					if $x <= 60 Then
						$_oldTimeLeftSecs = Floor($x)
						$_oldTimeLeftMins = 0
						$_oldTimeLeftHrs = 0

					Else
						$_oldTimeLeftSecs = Floor((($x/60)-Floor($x/60))*60)
						$_oldTimeLeftMins = Floor($x/60)


					if  60< $x < 360 Then
						$_oldTimeLeftMins = Floor($x/60)
					Else
						$_oldTimeLeftMins = Floor((($x/3600)-Floor($x/3600))*3600)
						$_oldTimeLeftHrs = Floor($x/3600)

					if $x > 360 Then
						$_oldTimeLeftHrs = Floor($x/3600)
					EndIf
					EndIf
					EndIf
					GUICtrlSetData($_timeLeft,$_oldTimeLeftHrs&" hours "&$_oldTimeLeftMins&" mins "&$_oldTimeLeftSecs&" secs left")
					GUICtrlSetData($_isDownloadSpeed,$_oldisDownloadSpeed&" kb/s")
					Sleep(0)

			Next


				until $i = $GUI_EVENT_CLOSE





EndFunc





Func _Pause()



EndFunc


Func _Cancel()
	InetClose($hdownload)
	EndFunc


























Func CLOSEButton()
	Exit
	EndFunc



















EndIf




Endfunc