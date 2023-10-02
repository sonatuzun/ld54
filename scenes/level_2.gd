extends Node2D

func _physics_process(delta):
	if $Enemies.get_child_count() == 0:
		$Link/YOUWIN.visible = true
		await get_tree().create_timer(10).timeout
		get_tree().change_scene_to_file("res://MainMenu.tscn")
	


func _on_link_player_died():
	await get_tree().create_timer(2).timeout
	get_tree().reload_current_scene()
	pass # Replace with function body.


func _on_anounce_restart_timer_timeout():
	$Link/TEXT/Restart.visible = true
	pass # Replace with function body.


func _on_hide_how_to_play_timer_timeout():
	$"Link/TEXT/How to play".visible = false
	pass # Replace with function body.
