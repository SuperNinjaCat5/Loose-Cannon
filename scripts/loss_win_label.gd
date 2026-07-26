extends Label

func _ready() -> void:
	GameManager.level_loss.connect(_on_level_loss) 

func _on_level_loss():
	text = "YOU RAN OUT OF POTIONS"
