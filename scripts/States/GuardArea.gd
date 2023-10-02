extends State
class_name GuardAreaState

@export var rb : RigidBody2D
@export var EnergyBallPrefab: PackedScene
var player

var lastShootTime = 0
var canShoot = true
var COOLDOWN = 3.0

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
		
	if rb && player && canShoot:
		shoot()
		
func shoot():
	var ball = EnergyBallPrefab.instantiate()
	add_child(ball)
	
	var shootDir = (player.global_position - global_position).normalized()
	var spawnPos = global_position + shootDir * 5
	ball.fire(shootDir, spawnPos)
	canShoot = false
	start_cooldown_timer(COOLDOWN)
	
func start_cooldown_timer(cooldown):
	var timer = get_tree().create_timer(cooldown)
	timer.timeout.connect(on_cooldown_finished)
	
func on_cooldown_finished():
	canShoot = true
	
func _on_detection_area_body_entered(body):
	if body == player:
		print("enemy trying to throw something")
		# throw something
