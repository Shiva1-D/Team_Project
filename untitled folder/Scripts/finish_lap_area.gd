extends Area3D

func _on_Area_body_entered(body):
	if body.is_in_group("player") and GameMain.currentLap < GameMain.totalLaps:
		GameMain.currentLap += 1
		var laps_nodes = get_tree().get_nodes_in_group("laps")
		if laps_nodes.size() > 0:
			laps_nodes[0].text = "Lap " + str(GameMain.currentLap) + "/" + str(GameMain.totalLaps)
		else:
			print("Error: No node in group 'laps' found")

		var panel_nodes = get_tree().get_nodes_in_group("panel")
		if panel_nodes.size() > 0:
			panel_nodes[0].visible = GameMain.currentLap >= GameMain.totalLaps
		else:
			print("Error: No node in group 'panel' found")
