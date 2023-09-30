extends Node2D
class_name HpComponent

@export var INITIAL_HP := 30
var curr_hp = INITIAL_HP

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func take_damage(amount):
	curr_hp -= amount
	if(curr_hp <= 0):
		get_parent().queue_free()
