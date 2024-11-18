extends VehicleBody3D

# Constants for controlling vehicle behavior
const VEL_DIREC = 2.5
const LIMIT_DIREC = 0.6

# Direction to face when steering
var direc_target = 0.0
# Forward velocity, similar to a speedometer
var fwd_vel = 0.0

@onready var engine_audio = $AudioStreamPlayer3D

@export var engine_force_value = 280.0
@export var brake_force_value = 5.0
@export var max_vel = 200.0
@export var max_back_vel = 150.0

func _ready():
	# Hide the mouse cursor during gameplay
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	show_speed_meter_in_hud()
	move_car(delta)

func _input(_event):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func show_speed_meter_in_hud():
	if fwd_vel > 0:
		get_tree().get_nodes_in_group("velocity")[0].text = str(fwd_vel) + " Km/h"
	else:
		get_tree().get_nodes_in_group("velocity")[0].text = "0 Km/h"


func move_car(delta):
	# Transform the linear velocity into the vehicle's local space using global_transform.basis
	var local_velocity = global_transform.basis.inverse() * linear_velocity
	fwd_vel = local_velocity.z  # Use the Z-axis component for forward velocity

	# Steering direction input (+1 for left, -1 for right)
	direc_target = Input.get_action_strength("move_left") - Input.get_action_strength("move_right")
	direc_target *= LIMIT_DIREC

	if Input.is_action_pressed("move_forward"):
		if fwd_vel < max_vel:
			engine_force = engine_force_value
		else:
			engine_force = 0.0
	else:
		engine_force = 0.0

	if Input.is_action_pressed("move_backward"):
		if fwd_vel >= 1:
			brake = brake_force_value
		elif fwd_vel >= -max_back_vel:
			engine_force = -engine_force_value
		else:
			engine_force = 0.0
	else:
		brake = 0.0

	# Use lerp to gradually move steering towards the target direction
	steering = lerp(steering, direc_target, VEL_DIREC * delta)
	if fwd_vel == 0:
		engine_audio.pitch_scale = 1.0 +(fwd_vel/max_vel) *0.5
		if not engine_audio.playing:
			engine_audio.play()
	else:
		engine_audio.stop
		
	if fwd_vel > 0:
		engine_audio.pitch_scale = 1.0 + (fwd_vel / max_vel) * 0.5
		if not engine_audio.playing:
			engine_audio.play()
	else:
		engine_audio.stop()
