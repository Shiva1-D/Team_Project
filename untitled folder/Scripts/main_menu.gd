class_name MainMenu
extends Control

@onready var start_button = $"MarginContainer/HBoxContainer/VBoxContainer/Start Game" as Button
@onready var exit_button = $"MarginContainer/HBoxContainer/VBoxContainer/Exit" as Button
@onready var start_level = preload("res://Scenes/First-Level.tscn") as PackedScene

func _ready():
	# Correct connection using Callable for the signal handlers
	start_button.connect("pressed", Callable(self, "_on_start_pressed"))
	exit_button.connect("pressed", Callable(self, "_on_exit_pressed"))

func _on_start_pressed() -> void:
	if start_level == null:
		print("Error: start_level could not be loaded. Check the scene path.")
	else:
		print("Start Level Loaded: ", start_level)
		get_tree().change_scene_to_packed(start_level)

func _on_exit_pressed() -> void:
	get_tree().quit()
