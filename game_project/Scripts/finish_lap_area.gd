extends Area3D

func _on_Area_body_entered(body):
	if body.is_in_group("player") and GameMain.currentLap < GameMain.totalLaps:
		GameMain.currentLap += 1
		var laps_text = "Lap %d/%d" % [GameMain.currentLap, GameMain.totalLaps]
		get_tree().get_nodes_in_group("laps")[0].text = laps_text
		
		if GameMain.currentLap >= GameMain.totalLaps:
			get_tree().get_nodes_in_group("panel")[0].visible = true
		else:
			get_tree().get_nodes_in_group("panel")[0].visible = false
