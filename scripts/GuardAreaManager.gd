extends Node2D
class_name GuardAreaManager

var guardAreas : Array = []

var addedChildren = false
# Called when the node enters the scene tree for the first time.
func _ready():	
	add_childs()
	
func add_childs():
	for child in get_children():
		if child is Area2D:
			guardAreas.append(child)
	addedChildren = true
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func GetClosestGuardAreaWithinLimit(requesterPos : Vector2, maxDistance : float):
	if(!addedChildren):
		add_childs()
		
	var closestArea = null
	var closestDist = 999999.0
	for area in guardAreas:
		var dist = area.global_position.distance_to(requesterPos)
		if dist < maxDistance && dist < closestDist:
			closestDist = dist
			closestArea = area
	return closestArea
