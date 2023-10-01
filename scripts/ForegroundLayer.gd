extends ParallaxLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in 100:
		add_child( get_child(0).duplicate() )
		pass

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
