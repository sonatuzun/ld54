extends RigidBody2D

@export var state_m: StateMachine
	
func _on_detection_area_body_entered(body):
	if body.is_in_group("Player"):
		state_m.player_entered_vision(body)

func _on_detection_area_body_exited(body):
	if body.is_in_group("Player"):
		state_m.player_left_vision(body)


func _on_hp_component_hp_reached_zero():
	queue_free()
