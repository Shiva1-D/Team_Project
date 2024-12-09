extends RigidBody3D

@export var lifespan: float = 2.0  # Time before the bullet disappears
@export var damage: int = 10      # Example damage value

# Initialize the bullet with a given velocity
func initialize(velocity: Vector3):
	linear_velocity = velocity
	# Schedule bullet removal after its lifespan
	await get_tree().create_timer(lifespan).timeout
	queue_free()

# Handle collision events
func _on_body_entered(body: Node):
	# Example: Check if the hit body has a "take_damage" method
	if body.has_method("take_damage"):
		body.take_damage(damage)
	queue_free()  # Remove the bullet after collision
