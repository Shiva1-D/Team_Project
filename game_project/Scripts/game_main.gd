extends Node

# Game state variables
var right_click = false
var decrement = 0

# Total laps is customizable
var totalLaps = 3
var currentLap = 0
var time = 0

# Max and min values for camera zoom
const MAX_ZOOM = 110
const MIN_ZOOM = 40

# Camera references, these will be assigned in the `_ready()` function
var camera_reference = null
var camera = null

func _ready():
	# Initialize camera_reference and camera
	camera_reference = get_node_or_null("camera_reference")
	if camera_reference != null:
		camera = camera_reference.get_node_or_null("camera")
		if camera == null:
			print("Error: Camera node not found in camera_reference!")
	else:
		print("Error: camera_reference node not found in the scene!")

func _input(event):
	zoom_and_rotate_camera(event)

func reset_laps_and_time():
	currentLap = 0
	time = 0

func show_time_in_hud():
	# Convert time to minutes and seconds for display
	if time < 10:
		get_tree().get_nodes_in_group("time")[0].text = "00:0" + str(time)
	elif time < 60:
		get_tree().get_nodes_in_group("time")[0].text = "00:" + str(time)
	else:
		get_tree().get_nodes_in_group("time")[0].text = "Time over"

func zoom_and_rotate_camera(event):
	if event is InputEventMouseButton:
		if event.pressed:
			match event.button_index:
				MOUSE_BUTTON_WHEEL_UP:
					if camera != null and camera.fov > MIN_ZOOM:
						camera.fov -= 5
				MOUSE_BUTTON_WHEEL_DOWN:
					if camera != null and camera.fov < MAX_ZOOM:
						camera.fov += 5
		if event.button_index == MOUSE_BUTTON_RIGHT:
			right_click = event.pressed

	if right_click and event is InputEventMouseMotion and camera_reference != null:
		decrement = 1
		camera_reference.rotate(Vector3(0, -decrement, 0), event.speed.x / 1000)
		camera_reference.rotation_degrees.z = 0
	elif not right_click and decrement > 0 and camera_reference != null:
		camera_reference.rotation_degrees.y = 180
	elif not right_click and decrement < 0 and camera_reference != null:
		camera_reference.rotation_degrees.y = 180
