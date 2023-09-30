extends Area2D
class_name HitboxComponent

@export var hpComponent : HpComponent

# Called when the node enters the scene tree for the first time.
func _ready():
	collision_layer = 2
	collision_mask = 2
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func damage(amount):
	if (hpComponent):
		hpComponent.take_damage(amount)
