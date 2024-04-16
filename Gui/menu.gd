extends Control
signal restart
@onready var game=$"../game_manager"
var score=0
var best_score=0
func _on_pause_pressed():
	
	show()
	get_tree().set_pause(true)

func _on_unpause_pressed():
	if game.get_time()>1:
		hide()
		get_tree().set_pause(false)
	
func _on_restart_pressed():
	get_tree().set_pause(false)
	emit_signal("restart")
	hide()
	
func _process(delta):
	if get_tree().paused==true:
		show()
