extends Node2D

@onready var boundtangle: CollisionShape2D = $Level_Bounds/Boundtangle
@onready var camera: Camera2D = $Camera

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	### FIX THIS VIBE CODED SLOP!!!!!!!!!!!!!!!!!!!!! ###
	
	var rect: Rect2 = boundtangle.shape.get_rect()
	var global_pos: Vector2 = boundtangle.global_position + rect.position
	
	camera.limit_left = global_pos.x
	camera.limit_top = global_pos.y
	camera.limit_right = global_pos.x + rect.size.x
	camera.limit_bottom = global_pos.y + rect.size.y
