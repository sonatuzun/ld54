extends State
class_name GuardAreaState

@export var rb : RigidBody2D

var player

func id():
	return StateNames.GuardArea
	
	
func Enter(): # Override
	# Stop Moving
	if rb:
		rb.linear_velocity = Vector2.ZERO
		

func Update(delta: float): # Override
	if !player:
		player = get_tree().get_first_node_in_group("Player")
		
	if player:
		look_at(player.global_position)
#		print("guarding area")
			
func Physics_Update(_delta: float):
	if rb:
		rb.linear_velocity = Vector2.ZERO
		
