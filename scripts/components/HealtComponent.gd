extends Node2D

# Fix the type when add ':'
# @export var MAX_HEALT : float = 10
@export var MAX_HEALT := 10.0

var health : float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _damage(attack: Attack):
	
