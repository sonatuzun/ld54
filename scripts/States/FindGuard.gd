extends State
class_name EnemyIdle

@export var enemy: RigidBody2D
@export var move_speed = 150.0

var move_dir := Vector2.ZERO
var patrol_time: float

var hasTarget = false
var target_pos := Vector2.INF
var THRESHOLD = 2

func id():
	return StateNames.FindGuardArea
	
func Enter(): # Override
	var gaMngr = get_tree().get_first_node_in_group("GuardAreaManager")
	if gaMngr:
		var area:Area2D = gaMngr.GetClosestGuardAreaWithinLimit(global_position, 9999)
		if area:
			hasTarget = true
			target_pos = area.transform.get_origin()

func Update(delta: float): # Override
	if hasTarget:
		var hasReachedDest = target_pos.distance_to(global_position) < THRESHOLD
		if hasReachedDest:
			OnTransition.emit(self, StateNames.GuardArea)
		else:
			move_dir = (target_pos - global_position).normalized()
			
func Physics_Update(_delta: float):
	if enemy:
		enemy.linear_velocity = move_dir * move_speed
		
