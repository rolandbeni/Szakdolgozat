extends CharacterBody2D

var enemy_scene = preload("res://Sprite2D.gd") # Load the enemy scene
var num_enemies = 5 # Number of enemies to spawn

func _ready():
	spawn_enemies(num_enemies)

func spawn_enemies(num):
	for i in range(num):
		var new_enemy = enemy_scene.instance() # Instantiate the enemy scene
		var random_position = Vector2(randf_range(0, get_viewport_rect().size.x), randf_range(0, get_viewport_rect().size.y)) # Generate a random position on the screen
		new_enemy.position = random_position # Set the enemy's position to the random position
		get_parent().add_child(new_enemy) # Add the enemy to the parent of the character (assuming character is a child of another node)

