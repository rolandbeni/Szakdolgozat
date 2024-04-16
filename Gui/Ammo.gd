extends RichTextLabel

@onready var game=$"../game_manager"
var ammo=0

func _process(delta):
	ammo=game.get_ammo()
	text=""
	for i in range(ammo):
		text+="|"
	set_text(text)
