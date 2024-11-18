extends Camera3D

# Exported variables with proper type hints for Godot 4
@export var follow_this_path: NodePath
@export var target_distance: float = 4.0
@export var target_height: float = 2.0

# Internal variables
var follow_this: Node3D = null
var last_lookat: Vector3 = Vector3.ZERO

func _ready() -> void:
	# Assign the node to follow based on the exported path
	if follow_this_path != null:
		follow_this = get_node_or_null(follow_this_path) as Node3D
		if follow_this != null:
			last_lookat = follow_this.global_transform.origin
		else:
			print("Error: follow_this node not found.")
	else:
		print("Error: follow_this_path is not assigned.")

func _physics_process(delta: float) -> void:
	if follow_this == null:
		return

	# Calculate the difference in position and create the target position
	var delta_v: Vector3 = global_transform.origin - follow_this.global_transform.origin
	var target_pos: Vector3 = global_transform.origin

	# Ignore the y component to keep movement level
	delta_v.y = 0.0

	if delta_v.length() > target_distance:
		delta_v = delta_v.normalized() * target_distance
		delta_v.y = target_height
		target_pos = follow_this.global_transform.origin + delta_v
	else:
		target_pos.y = follow_this.global_transform.origin.y + target_height

	# Smoothly interpolate the camera's position towards the target position
	global_transform.origin = global_transform.origin.lerp(target_pos, delta * 20.0)

	# Smoothly interpolate the look-at position
	last_lookat = last_lookat.lerp(follow_this.global_transform.origin, delta * 20.0)

	# Make the camera look at the target smoothly
	look_at(last_lookat, Vector3.UP)
