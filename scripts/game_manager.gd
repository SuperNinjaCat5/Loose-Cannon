extends Node

signal level_loss
signal level_win
func _ready():
	GameManager.level_loss.connect(_on_level_loss)
	#GameManager.level_win.connect(_on_level_win)

var score: int = 0

func _on_level_loss():
	print("YOU LOSS BUMMMM")
