extends Node

signal level_loss
signal level_win

var cursor_texture = preload("res://assets/hand_open.png")
	
func _ready():
	GameManager.level_loss.connect(_on_level_loss)
	
	var img = cursor_texture.get_image()
	img.resize(41, 48, Image.INTERPOLATE_LANCZOS)
	var small_texture = ImageTexture.create_from_image(img)
	Input.set_custom_mouse_cursor(small_texture, Input.CURSOR_ARROW, Vector2(13, 7))
	
	#GameManager.level_win.connect(_on_level_win)

var score: int = 0

func _on_level_loss():
	print("YOU LOSS BUMMMM")
