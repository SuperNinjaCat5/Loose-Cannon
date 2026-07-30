extends Camera2D

@onready var level_corner: Marker2D = $"../level_corner"
@onready var origin: Vector2 = level_corner.global_position

@onready var targets = get_tree().get_nodes_in_group("camera_targets")

@export var min_zoom: float = 0.2
@export var max_zoom: float = 2.0
@export var margin_x: float = 500.0
@export var margin_y: float = 500.0
@export var smoothing_speed: float = 5.0

func _process(delta: float) -> void:
	targets = get_tree().get_nodes_in_group("camera_targets")
	var max_x_dist: float = 0.0
	var max_y_dist: float = 0.0
	var diff: Vector2
	
	for target in targets:
		diff = target.global_position - origin
		# Look right (positive X)
	if diff.x > max_x_dist:
		max_x_dist = diff.x
		# Look up (negative Y)
	if -diff.y > max_y_dist:
		max_y_dist = -diff.y
			
	max_x_dist += margin_x
	max_y_dist += margin_y
	
	var screen_size = get_viewport_rect().size
	
	var zoom_x = screen_size.x / max_x_dist
	var zoom_y = screen_size.y / max_y_dist
	
	var target_zoom_val = min(zoom_x, zoom_y)
	target_zoom_val = clamp(target_zoom_val, min_zoom, max_zoom)
	var target_zoom = Vector2(target_zoom_val, target_zoom_val)
	
	var world_screen_size = screen_size / target_zoom_val
	var target_position = origin + Vector2(world_screen_size.x / 2.0, -world_screen_size.y / 2.0)
	
	global_position = global_position.lerp(target_position, smoothing_speed * delta)
	zoom = zoom.lerp(target_zoom, smoothing_speed * delta)
