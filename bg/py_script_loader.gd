extends Node



func _ready():
	var path = "res://hand-tracking/hand_tracker.py"
	var result = OS.execute('python', [path])
	print(result)
	if result == OK:
		print("Script executed successfully")
	else:
		print("Error executing script")
