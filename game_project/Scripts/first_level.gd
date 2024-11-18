extends Node3D


func _on_Timer_timeout():
	GameMain.time += 1
	GameMain.show_time_in_hud()
