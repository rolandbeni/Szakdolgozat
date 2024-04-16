extends CharacterBody2D

@onready var game=$"../game_manager"
var speed:float = 150
@onready var raven=$AnimatedSprite2D
var is_visible = true
var timer = 0
var invisible_duration = 1.5

func _ready():
	input_pickable=true
	velocity.x=speed

func _process(delta):
	
	var col=move_and_collide(velocity * delta)
	if col:
		velocity.x*=-1
	check_direction()
	if !is_visible:
		timer-=delta
		if timer<=0:
			show()
			is_visible=true
			
			
func check_direction():
	if velocity.x<0:
		raven.flip_h=true
	else:
		raven.flip_h=false
		


func _on_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("shoot"):
		if game.get_ammo()>0:
			
			hide()
			is_visible=false
			timer=invisible_duration
			game.set_score(10+abs(velocity.x)/10)
			if velocity.x<0:
				velocity.x-=50
			else:
				velocity.x+=50
func _on_control_restart():
	get_tree().reload_current_scene()
