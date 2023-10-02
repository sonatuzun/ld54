extends RigidBody2D

var _playerPositionIsKnown := false
var _player
var ACCELERATION = 1200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# todo: move to another node maybe
	var time = Time.get_unix_time_from_system()
	$Sprite2D.offset.y = sin(time * 5) * 100
	pass

func _physics_process(delta):
	if _playerPositionIsKnown and _player:
		var diff = _player.position - position
		var impulse = diff.normalized() * ACCELERATION * mass
		apply_central_force(impulse)

	var facingRight = linear_velocity.x < 0.0
	$Sprite2D.flip_h = facingRight
	$DetectionArea.scale.x = -1.0 if facingRight else 1.0
	$HurtBox.scale.x = -1.0 if facingRight else 1.0

func _on_detection_area_body_entered(body):
	print("body entered")
	if body.is_in_group("Player"):
		_playerPositionIsKnown = true
		_player = body 
	pass # Replace with function body.


func _on_detection_area_body_exited(body):
	if body.is_in_group("Player"):
		_playerPositionIsKnown = false
		_player = null
		pass
	pass # Replace with function body.


func _on_hp_component_hp_reached_zero():
	await get_tree().create_timer(0.2).timeout
	queue_free()
