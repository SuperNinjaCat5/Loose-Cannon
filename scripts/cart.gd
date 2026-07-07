extends Node2D

@export var cannon_motor_speed = 100
@export var wheel_motor_speed = 25

@export var PROJECTILE = preload("res://scenes/cannon_ball.tscn")

@onready var front_wheel_joint: PinJoint2D = $Front_Wheel_Joint
@onready var back_wheel_joint: PinJoint2D = $Back_Wheel_Joint

@onready var cannon_joint = $Cannon_Joint
@onready var cannon_rb = $Cannon_Joint/Cannon

@onready var fire_marker = $Cannon_Joint/Cannon/Fire_Marker
@onready var power_progress_bar = $Cannon_Joint/Cannon/Cannon_Power_Bar

var IsUsingCart: bool = true

var IsAiming: bool = 0
var AimingTime: float = 0

@onready var bar_stylebox = power_progress_bar.get_theme_stylebox("fill").duplicate()
const COOLDOWN_RED := Color("bf2639")
const KILL_THEM_ALL_GREEN := Color("49a078")
var attempted_aim_dur_cooldown: bool = false

@export var cannon_power: float = 100
var calced_power: float
@onready var cannon_cooldown = $Cannon_Joint/Cannon/Cannon_Cooldown

func _ready() -> void:
	power_progress_bar.add_theme_stylebox_override("fill", bar_stylebox)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if IsUsingCart != true:
		return
		
	front_wheel_joint.motor_target_velocity = Input.get_axis("Left","Right") * wheel_motor_speed
	back_wheel_joint.motor_target_velocity = Input.get_axis("Left","Right") * wheel_motor_speed
	
	cannon_joint.motor_target_velocity = Input.get_axis("Up","Down") * cannon_motor_speed
	
	if(cannon_joint.motor_target_velocity == 0):
		cannon_rb.lock_rotation = true
	else:
		cannon_rb.lock_rotation = false
		
	if IsAiming == true: 
		AimingTime += delta # Update Aiming time
		calced_power = abs(cannon_power * sin(AimingTime)) # Calc Power
		power_progress_bar.value = calced_power / cannon_power * 100 # Update Bar
	elif !cannon_cooldown.is_stopped():
		power_progress_bar.value = cannon_cooldown.time_left / cannon_cooldown.wait_time * 100

func _unhandled_input(event: InputEvent) -> void:
	if !cannon_cooldown.is_stopped():
		attempted_aim_dur_cooldown = true
		return
	if event.is_action_pressed("Interact"):
		bar_stylebox.bg_color = KILL_THEM_ALL_GREEN # Set the bar green
		IsAiming = true
		AimingTime = 0
	elif event.is_action_released("Interact"):
		IsAiming = false
		if attempted_aim_dur_cooldown == false:
			fire_cannon_ball(calced_power)
		else:
			attempted_aim_dur_cooldown = false
		
func fire_cannon_ball(power) -> void:
	var pro = PROJECTILE.instantiate()
	cannon_rb.add_sibling(pro)
	pro.global_position = fire_marker.global_position
	pro.linear_velocity = cannon_rb.global_transform.x * power
	cannon_cooldown.start()
	bar_stylebox.bg_color = COOLDOWN_RED

func _on_cannon_cooldown_timeout() -> void:
	power_progress_bar.value = 0
	IsAiming = false
	calced_power = 0
