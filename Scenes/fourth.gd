extends Node3D



@onready var pause_button = $HBoxContainer/VBoxContainer/PauseButton as Button
@onready var unpause_button = $HBoxContainer/VBoxContainer/PauseButton as Button
 # Connect the pause button
func _ready():
	pause_button.connect("pressed", Callable(self, "_on_pause_pressed"))

func _on_pause_pressed() -> void:
	if get_tree().paused:# Unpause the game
		get_tree().paused = false
		print("Game Resumed")
	else:# Pause the game
		get_tree().paused = true
		print("Game Paused")

func _on_exit_pressed() -> void:
	get_tree().quit()
	
func _on_Timer_timeout():
	GameMain.time += 1
	GameMain.show_time_in_hud()
