extends Node



func _ready():
	var path = "C:/Users/aztah/Szakdolgozat/hand-tracking/dist/hand_tracker.exe"
	var result = OS.execute(path, [])
	if result == OK:
		print("Script executed successfully")
	else:
		print("Error executing script")
