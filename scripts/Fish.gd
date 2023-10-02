extends RigidBody2D


func _physics_process(delta):
	rotation = linear_velocity.angle() + 0.9 * PI
	$Node2D/Rotator.scale.y = 1 if (int(rotation_degrees) + 450 + 180) % 360 > 180 else -1
