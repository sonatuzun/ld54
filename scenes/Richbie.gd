extends RigidBody2D

var _moveDir = Vector2.LEFT.rotated(randf() * 2 * PI)
const ACCELERATION = 10

func _physics_process(delta):
	apply_central_impulse(_moveDir * ACCELERATION * mass)
	$AnimatedSprite2D.flip_h = _moveDir.x > 0
	pass

func _on_decision_timer_timeout():
	_moveDir = Vector2.LEFT.rotated(randf() * 2 * PI)
	pass # Replace with function body.


func _on_hp_component_hp_reached_zero():
	await get_tree().create_timer(1.0)
	queue_free()
	pass # Replace with function body.
