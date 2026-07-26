extends RigidBody2D

#@onready var orb_canvas_group: CanvasGroup = $Orb_Canvas_Group
#@onready var orb: RigidBody2D = $Orb_Canvas_Group/Orb
@export var potion_data: Potion_Data = Potion_Data.new()

@export var liquid_fill_percent: float = .5
var max_orbs: int = 50

@export var break_speed = 100

func _on_body_entered(body: Node) -> void:
	if linear_velocity.length() >= break_speed:
		break_bottle(body)

func break_bottle(body: Node):
	var collision_poly: CollisionPolygon2D = find_child("Bottle" + str(potion_data.sprite_id))
	collision_poly.set_deferred("disabled", true) # Disable collision
	var sprite: Sprite2D = find_child("sprite")
	sprite.visible = false
	
	apply_effects()

func apply_effects():
	pass
