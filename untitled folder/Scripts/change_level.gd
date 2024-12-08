extends Button

# Called when the button to change levels is pressed
func _on_ChangeLevelButton_pressed():
	# TODO: If I'm in level one, go to level two and vice versa
	change_to_second_level()
	GameMain.reset_laps_and_time()

# Handle user inputs
func _input(_event):
	if _event is InputEventKey:
		if Input.is_action_pressed("level_one"):
			change_to_first_level()
		elif Input.is_action_pressed("level_two"):
			change_to_second_level()

# Change to the first level
func change_to_first_level():
	# Reload the first level scene
	get_tree().change_scene("res://Scenes/First-Level.tscn")
	GameMain.reset_laps_and_time()

# Change to the second level
func change_to_second_level():
	# Reload the second level scene
	get_tree().change_scene("res://Scenes/Second-Level.tscn")
	GameMain.reset_laps_and_time()
