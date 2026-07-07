extends Node2D

@onready var boundtangle = $Level_Bounds/Boundtangle
@onready var camera = $Camera

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# COLLISION
	
	var contact_boxes = find_children("*", "CollisionPolygon2D")
	for box in contact_boxes:
		var polys = box.get_parent().find_children("*", "Polygon2D")
		
		if polys.is_empty():
			printerr("Contact Box, ", box, " is missing a texture!")
		
		var texture = polys[0]
		
		box.polygon = texture.polygon
		
	# CAMERA
	### BROKEN AND VIBE CODED FIX LATER!!!!!!!
	#var shape = boundtangle.shape as RectangleShape2D
	#var extents = shape.size / 2
	#var global_pos = boundtangle.global_position
#
	#camera.limit_left = global_pos.x - extents.x
	#camera.limit_top = global_pos.y - extents.y
	#camera.limit_right = global_pos.x + extents.x
	#camera.limit_bottom = global_pos.y + extents.y
	#
	#camera.global_position = global_pos
	#var viewport_size = get_viewport_rect().size
	#var level_size = shape.size  # full size, not extents
	#var zoom_factor = max(level_size.x / viewport_size.x, level_size.y / viewport_size.y)
	#camera.zoom = Vector2(zoom_factor, zoom_factor)
	#camera.make_current()
	
