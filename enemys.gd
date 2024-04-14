extends CharacterBody2D

@onready var enemy = $Sprite2D 
var timer = 0
var appear_time = 3
var invisible_duration = 1
var invisible_time =1
var is_visible = true


func _ready():
	
	enemy.position= Vector2(randf_range(150, get_viewport_rect().size.x-150),
	randf_range(75, get_viewport_rect().size.y-75)) 
	
	timer = appear_time
	pass

func _process(delta):

	timer -= delta


	if timer <= 0:
		is_visible = !is_visible
		if is_visible:
			respawn_enemy()
			timer = appear_time
		else:
			hide_enemy()
			timer = invisible_time

func respawn_enemy():
	enemy.position= Vector2(randf_range(150, get_viewport_rect().size.x-150), randf_range(75, get_viewport_rect().size.y-75))
	show() 

func hide_enemy():
	hide()
