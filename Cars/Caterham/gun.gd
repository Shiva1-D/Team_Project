extends Node3D

@export var bullet_scene: PackedScene  # Assign your bullet scene in the editor
@export var fire_rate: float = 0.5    # Time between shots in seconds
@export var bullet_speed: float = 50.0

var can_shoot: bool = true

@onready var muzzle: Node3D = $Muzzle  # Ensure your muzzle node is named "Muzzle"

# Called to fire a bullet
func shoot():
	if not can_shoot:
		return
	
	can_shoot = false

	# Create and spawn the bullet
	var bullet = bullet_scene.instantiate()
	get_tree().root.add_child(bullet)

	# Position the bullet at the muzzle
	bullet.global_transform = muzzle.global_transform

	# Pass the velocity to the bullet
	if bullet.has_method("initialize"):
		bullet.call("initialize", muzzle.global_transform.basis.z * bullet_speed)

	# Reset shooting cooldown after fire_rate seconds
	await get_tree().create_timer(fire_rate).timeout
	can_shoot = true
