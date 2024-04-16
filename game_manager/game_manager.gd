extends Node
@onready var menu=$"../Control"
@onready var save=$"../Save_best_score"
var ammo:int =6
var game_time=60
var score=0
var best_score=0
signal endgame


func _ready():
	ammo=6
	game_time=60
	score=0
	#best_score=save.load_()
	
func _process(delta):
	game_time-=delta
	if game_time<=0:
		if score>best_score:
			best_score=score
			#var data = {"score": best_score }   
			#save.save(data)
		emit_signal("endgame")
		get_tree().set_pause(true)
		game_time=1
		
func get_time():
	return int(game_time)

func get_scores():
	return Vector2(score, best_score)

func shoot_ammo():
	ammo-=1
	
func get_ammo():
	return ammo

func set_score(x):
	score+=x
	

func set_best_score(score):
	best_score=score

func _input(event):
	if event.is_action_pressed("reload"):
		if ammo <6:
			ammo+=1
		else:
			ammo=6
	if event.is_action_pressed("shoot"):
		if ammo>=1:
			shoot_ammo()
		else:
			ammo=0
			

func _on_control_restart():
	get_tree().reload_current_scene()
