extends Node2D
class_name GuardAreaManager

var guardAreas : Array = []
# Called when the node enters the scene tree for the first time.
func _ready():	
	for child in get_children():
		if child is Area2D:
			guardAreas.append(child)
			#child.OnTransition.connect(on_child_transition)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func GetClosestGuardAreaWithinLimit(requesterPos : Vector2, maxDistance : float):
	for area in guardAreas:
		if area.position
	pass
