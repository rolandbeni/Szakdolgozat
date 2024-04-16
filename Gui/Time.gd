extends RichTextLabel

@onready var game=$"../game_manager"
var Game_time=0

func _process(delta):
	Game_time=game.get_time()
	set_text(str(Game_time)+"s")
