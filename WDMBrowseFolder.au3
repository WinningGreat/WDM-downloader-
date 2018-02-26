

Func _btnBrowse($InputFolder,$oldFolderInput)



			$oldFolderInput = FileSelectFolder("Select Download Folder","",0,GUICtrlRead($InputFolder))
			GUICtrlSetData($InputFolder,$oldFolderInput)
			EndFunc