extends CharacterBody2D

@export var movementSpeed: float = 200.0
@export var movementTarget: Node2D
@export var navigationAgent: NavigationAgent2D

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#The distance threshold before a path point is considered to be reached.
	navigationAgent.path_desired_distance = 4.0
	
	#The distance threshold before the final target point is considered to be reached.
	navigationAgent.target_desired_distance = 4.0
	
	call_deferred("actor_setup")
 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	if navigationAgent.is_navigation_finished():
		return
		
	var currentAgentPosition: Vector2 = global_position
	var nextPathPosition: Vector2 = navigationAgent.get_next_path_position()
	
	var direction: Vector2 = (nextPathPosition - currentAgentPosition).normalized()
	var newVelocity: Vector2 = direction * movementSpeed
	
	navigationAgent.set_velocity(newVelocity)
	

func actor_setup():
	await get_tree().physics_frame
	
	set_movement_target(movementTarget.position)
	
func set_movement_target(targetPoint: Vector2):
	navigationAgent.target_position = targetPoint
	
	

func _on_navigation_agent_2d_velocity_computed(safeVelocity):
	velocity = safeVelocity
	move_and_slide()
