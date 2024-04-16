extends RichTextLabel

@onready var game=$"../game_manager"
var score=0
var best_score=0

func _process(delta):
	score=game.get_scores().x
	best_score=game.get_scores().y
	set_text("Best Score: " + str(best_score) + "\n" + "Score: " + str(score))
