extends VehicleBody3D

# This is the direction velocity
const VEL_DIREC = 1
# Custom number to limit the steering direction
const LIMIT_DIREC = 0.4

# The direction where we want to face when steering
var direc_target = 0.0
# Forward velocity, it's like a speedometer 
var fwd_vel = 0.0

@export var engine_force_value = 280.0
# Warning, brake value range is from 0 to 1, but 5 works. Check documentation
@export var brake_force_value = 5.0
@export var max_vel = 200.0
@export var max_back_vel = 150.0

func _ready():
	# This is to avoid seeing the mouse cursor
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
	# Calculate forward velocity directly from the linear velocity vector.
	fwd_vel = linear_velocity.length()
	# Convert the velocity to km/h
	fwd_vel = round(fwd_vel * 3.6 * 10) / 10.0

	# If we want to turn left, it is +1; to turn right, it is -1
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

	# Steering towards direction
	steering = move_toward(steering, direc_target, VEL_DIREC * delta)
