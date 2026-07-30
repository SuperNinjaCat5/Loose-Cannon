extends Control
#
@onready var h_box_container: HBoxContainer = $HBoxContainer

var is_ready: bool = false

func _ready() -> void:
	PotionManager.held_potions_changed.connect(_on_held_potions_changed)
	is_ready = true
	_on_held_potions_changed()

func _on_held_potions_changed() -> void:
	#for potion_data in PotionManager.held_potions:
	if not is_ready:
		return
		
	var i = 0
	
	for texture_rect: TextureRect in h_box_container.get_children():
		
		for child in texture_rect.get_children():
			texture_rect.remove_child(child)
			child.queue_free()
		
		if i < PotionManager.held_potions.size():
			var potion_data = PotionManager.get_potion(i)
			
			var sprite = Sprite2D.new()
			var texture = load(potion_data.sprite_path)
			sprite.texture = texture
			sprite.scale = Vector2(.35,.35)
			sprite.position = Vector2(207, 208) 
			
			texture_rect.add_child(sprite)
			i += 1
		else:
			texture_rect.visible = false
		
