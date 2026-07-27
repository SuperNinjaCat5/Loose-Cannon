extends TextureProgressBar

const COOLDOWN_RED := Color("bf2639")
const KILL_THEM_ALL_GREEN := Color("49a078")

const COOLDOWN_TEXTURE: Texture2D = preload("res://assets/cooldown_bar_texture.tres")
const POWER_BAR_TEXTURE: Texture2D = preload("res://assets/power_bar_texture.tres")

func _on_cart_cannon_bar_color_changed(color: Color) -> void:
	if color == KILL_THEM_ALL_GREEN:
		texture_progress = POWER_BAR_TEXTURE
	elif color == COOLDOWN_RED:
		texture_progress = COOLDOWN_TEXTURE
	else:
		print("_on_cart_cannon_bar_color_changed was sent not the right color")

func _on_cart_cannon_power_changed(power_percent: float) -> void:
	value = power_percent
