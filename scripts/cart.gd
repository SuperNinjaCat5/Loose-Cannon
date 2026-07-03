extends Node2D

const cannon_motor_speed = 100
const wheel_motor_speed = 15

@onready var front_wheel_joint = $Front_Wheel_Joint
@onready var back_wheel_joint = $Back_Wheel_Joint

@onready var cannon_joint = $Cannon_Joint
@onready var cannon_rb = $Cannon_Joint/Cannon
var PlayerIsUsingCart: bool = true

func _ready():
	print("=== READY ===")
	print("cannon_rb name: ", cannon_rb.name)
	print("cannon_rb path: ", cannon_rb.get_path())
	print("gravity_scale BEFORE: ", cannon_rb.gravity_scale)
	cannon_rb.gravity_scale = 0
	cannon_rb.angular_damp = 8.0
	cannon_joint.angular_limit_enabled = true
	cannon_joint.angular_limit_lower = deg_to_rad(-45)
	cannon_joint.angular_limit_upper = deg_to_rad(-4)
	print("gravity_scale AFTER: ", cannon_rb.gravity_scale)
	print("angular_limit_enabled: ", cannon_joint.angular_limit_enabled)
	print("angular_limit_lower: ", cannon_joint.angular_limit_lower, " (", rad_to_deg(cannon_joint.angular_limit_lower), " deg)")
	print("angular_limit_upper: ", cannon_joint.angular_limit_upper, " (", rad_to_deg(cannon_joint.angular_limit_upper), " deg)")
	print("cannon_joint node_a: ", cannon_joint.node_a)
	print("cannon_joint node_b: ", cannon_joint.node_b)
	print("=============")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if PlayerIsUsingCart != true:
		return
		
	front_wheel_joint.motor_target_velocity = Input.get_axis("Left","Right") * wheel_motor_speed
	back_wheel_joint.motor_target_velocity = Input.get_axis("Left","Right") * wheel_motor_speed
	
	cannon_joint.motor_target_velocity = Input.get_axis("Up","Down") * cannon_motor_speed
	
	#if(cannon_joint.motor_target_velocity == -cannon_motor_speed and cannon_rb.rotation_degrees  <= -45): 
		#cannon_rb.lock_rotation = true
	#elif(cannon_joint.motor_target_velocity == +cannon_motor_speed and cannon_rb.rotation_degrees  >= -4):
		#cannon_rb.lock_rotation = true
	#else: 
		#cannon_rb.lock_rotation = false
		
	print(cannon_rb.rotation_degrees, " ", cannon_joint.motor_target_velocity)
