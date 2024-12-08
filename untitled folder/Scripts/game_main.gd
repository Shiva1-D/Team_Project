extends Node2D

# Constants for Zoom Limits
const MAX_ZOOM = 110
const MIN_ZOOM = 40

# Game state variables
@export var totalLaps = 3
var currentLap = 0
var time = 0.0

# Camera control variables
var right_click = false
var rotation_reset_speed = 0.1  # Speed at which the camera resets

# Declare camera references
var camera_reference = null
var camera = null

func _ready():
	# Find the camera_reference node dynamically
	camera_reference = get_node_or_null("camera_reference")
	if camera_reference != null:
		print("camera_reference found: ", camera_reference)

		# Find the camera node as a child of camera_reference
		camera = camera_reference.get_node_or_null("camera")
		if camera != null:
			print("camera found: ", camera)
		else:
			print("Error: camera node not found within camera_reference!")
	else:
		print("Error: camera_reference node not found in the scene!")
	
	# Reset laps and time when the game starts
	reset_laps_and_time()

func _process(delta):
	# Update the timer
	time += delta
	show_time_in_hud()

	# Smoothly reset the camera's rotation if right-click is released
	if not right_click and camera_reference != null:
		var current_rotation = camera_reference.rotation_degrees.y
		camera_reference.rotation_degrees.y = lerp(current_rotation, 180, rotation_reset_speed * delta)

func _input(_event):
	zoom_and_rotate_camera(_event)

func reset_laps_and_time():
	currentLap = 0
	time = 0.0

func show_time_in_hud():
	# Convert time to minutes and seconds for display
	var total_time = int(time)  # Convert time from float to int
	var minutes = total_time / 60
	var seconds = total_time % 60

	# Get the HUD label for displaying time
	var time_label = get_tree().get_nodes_in_group("time")
	if time_label.size() > 0:
		# Manually format the time string with leading zeros
		var minutes_str = "0" + str(minutes) if minutes < 10 else str(minutes)
		var seconds_str = "0" + str(seconds) if seconds < 10 else str(seconds)
		time_label[0].text = minutes_str + ":" + seconds_str
	else:
		print("Error: No node found in group 'time'")

func zoom_and_rotate_camera(_event):
	if _event is InputEventMouseButton:
		if _event.pressed:
			match _event.button_index:
				MOUSE_BUTTON_WHEEL_UP:
					if camera and camera.fov > MIN_ZOOM:
						camera.fov -= 5
				MOUSE_BUTTON_WHEEL_DOWN:
					if camera and camera.fov < MAX_ZOOM:
						camera.fov += 5
			if _event.button_index == MOUSE_BUTTON_RIGHT:
				right_click = true
		else:
			if _event.button_index == MOUSE_BUTTON_RIGHT:
				right_click = false

	if right_click and _event is InputEventMouseMotion and camera_reference != null:
		var decrement = 1
		camera_reference.rotate(Vector3(0, -decrement, 0), _event.speed.x / 1000)
		camera_reference.rotation_degrees.z = 0
