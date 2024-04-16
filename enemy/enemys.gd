extends CharacterBody2D

@onready var game=$"../game_manager"
@onready var enemy = $Sprite2D 
var timer = 0
var appear_time = 3
var invisible_duration = 1.5
var is_visible = true
var bonus=0

func _ready():
	
	input_pickable=true
	enemy.position= Vector2(randf_range(150, get_viewport_rect().size.x-150),
	randf_range(400,600)) 
	enemy.scale=Vector2(0.002+enemy.position.y*0.0006, 0.002+enemy.position.y*0.0006)
	timer = appear_time
	pass

func _process(delta):

	
	if is_visible:
		timer -= delta
		if timer <= 0:
			hide_enemy()
			
	else:
		timer-=delta
		if timer<=0:
			respawn_enemy()
			

func respawn_enemy():
	enemy.position= Vector2(randf_range(150, get_viewport_rect().size.x-150), randf_range(400, 600))
	enemy.scale=Vector2(0.002+enemy.position.y*0.0006, 0.002+enemy.position.y*0.0006)
	timer = appear_time
	is_visible=true
	show() 
	
	

func _input(event):
	if event.is_action_pressed("shoot"):
		if game.get_ammo()>0:
			var mouse_position = get_global_mouse_position()
			var enemy_rect = enemy.get_rect()
			if enemy_rect.has_point(enemy.to_local(mouse_position)):
				game.set_score(75+bonus)
				bonus+=5
				invisible_duration-=0.05
				appear_time-=0.05
				hide_enemy()

func hide_enemy():
	is_visible = false
	timer=invisible_duration
	hide()

func _on_control_restart():
	get_tree().reload_current_scene()
