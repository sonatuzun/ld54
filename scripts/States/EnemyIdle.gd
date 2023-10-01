extends State
class_name EnemyIdle

@export var enemy: RigidBody2D
@export var move_speed = 150.0

var move_dir := Vector2.ZERO
var patrol_time: float


func id():
	return StateNames.Idle
	
func Enter(): # Override
	start_patrolling()

func Update(delta: float): # Override
	if patrol_time > 0:
		patrol_time -= delta
	else:
		start_patrolling()

func Physics_Update(_delta: float):
	if enemy:
		enemy.linear_velocity = move_dir * move_speed
		
func start_patrolling():
	move_dir = Vector2(randf_range(-1,1), randf_range(-1,1)).normalized()
	patrol_time = randf_range(1,3)

func PlayerEnteredDetectionArea(body):
	# Leave Idle state, transition to Move towards Player state?
	OnTransition.emit(self, StateNames.GuardArea)
	pass
	
func PlayerLeftDetectionArea(body):
	pass
