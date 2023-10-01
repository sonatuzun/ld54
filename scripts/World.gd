extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_link_player_died():
	$Link/BrokenGlass.visible = true
	$CanvasModulate.visible = false
	await get_tree().create_timer(2).timeout
	get_tree().reload_current_scene()
	pass # Replace with function body.
