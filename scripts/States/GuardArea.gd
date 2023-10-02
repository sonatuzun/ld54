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
		
func Physics_Update(_delta: float):
	if rb && rb.linear_velocity != Vector2.ZERO:
		rb.linear_velocity = Vector2.ZERO
		
	if rb && player:
		rb.look_at(player.global_position)

func _on_detection_area_body_entered(body):
	if body == player:
		print("enemy trying to throw something")
		# throw something
