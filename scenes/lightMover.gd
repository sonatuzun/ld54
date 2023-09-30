extends PointLight2D

@export var ROTATION_SPEED = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var time = Time.get_unix_time_from_system()
	var rotationMod = time * ROTATION_SPEED
	rotation = sin(rotationMod*0.1) + sin(rotationMod*0.05) + sin(rotationMod*0.02)
	pass
