class_name MainMenu
extends Control
@onready var level1_button = $"MarginContainer/HBoxContainer/VBoxContainer/level1" as Button
@onready var level2_button = $"MarginContainer/HBoxContainer/VBoxContainer/level2" as Button
@onready var level3_button = $MarginContainer/HBoxContainer/VBoxContainer/level3 as Button
@onready var level4_button = $MarginContainer/HBoxContainer/VBoxContainer/level4
@onready var exit_button = $"MarginContainer/HBoxContainer/VBoxContainer/Exit" as Button
@onready var level1_scene = preload("res://Scenes/First-Level.tscn") as PackedScene
@onready var level2_scene = preload("res://Scenes/Second-Level.tscn") as PackedScene
@onready var level3_scene = preload("res://Scenes/Third-Level.tscn") as PackedScene
@onready var level4_scene = preload("res://Scenes/Fourth.tscn") as PackedScene

func _ready():
	# Connect buttons to their respective handlers
	level1_button.connect("pressed", Callable(self, "_on_level1_pressed"))
	level2_button.connect("pressed", Callable(self, "_on_level2_pressed"))
	level3_button.connect("pressed", Callable(self, "_on_level3_pressed"))
	level4_button.connect("pressed", Callable(self, "_on_level4_pressed"))
	exit_button.connect("pressed", Callable(self, "_on_exit_pressed"))

func _on_level1_pressed() -> void:
	if level1_scene == null:
		print("Error: level1_scene could not be loaded. Check the scene path.")
	else:
		print("Level 1 Loaded: ", level1_scene)
		get_tree().change_scene_to_packed(level1_scene)

func _on_level2_pressed() -> void:
	if level2_scene == null:
		print("Error: level2_scene could not be loaded. Check the scene path.")
	else:
		print("Level 2 Loaded: ", level2_scene)
		get_tree().change_scene_to_packed(level2_scene)
func _on_exit_pressed() -> void:
	get_tree().quit()
func _on_level3_pressed() -> void:
	if level3_scene == null:
		print("Error: level3_scene could not be loaded. Check the scene path.")
	else:
		print("Level 3 Loaded: ", level3_scene)
		get_tree().change_scene_to_packed(level3_scene)

func _on_level4_pressed() -> void:
	if level4_scene == null:
		print("Error: level4_scene could not be loaded. Check the scene path.")
	else:
		print("Level 4 Loaded: ", level4_scene)
		get_tree().change_scene_to_packed(level4_scene)
