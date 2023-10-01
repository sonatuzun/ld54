extends RigidBody2D

signal playerDied

var _faceDirection := Vector2.DOWN
var _spriteProgress := 0.0
const BASE_MOVEMENT_SPEED = 140000
const IDLE_ANIMATION_SPEED = 4
const RUNNING_ANIMATION_SPEED = 0.01
var _speedMultiplier = 1
var _velocity = Vector2()
const BASE_VELOCITY_LOSS = 0.1

# effects velocity gain and loss speeds to imitate differenct surfaces
# high traction: ground low traction: ice
var _surfaceTraction = 0.5

const SPRITE_ROW_LIMITS := [
	3,
	3,
	1,
	3,
	10,
	10,
	10,
	10
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func GetMoveDirection() -> Vector2:
	var moveDirection = Vector2()
	if Input.is_action_pressed("up"):
		moveDirection.y -= 1
	if Input.is_action_pressed("down"):
		moveDirection.y += 1
	if Input.is_action_pressed("left"):
		moveDirection.x -= 1
	if Input.is_action_pressed("right"):
		moveDirection.x += 1
	moveDirection = moveDirection.normalized()
	return moveDirection

func HandleMovement(delta, moveDir : Vector2):
	moveDir = moveDir.normalized()
	apply_central_impulse(moveDir * BASE_MOVEMENT_SPEED * delta * _speedMultiplier * _surfaceTraction)

func HandleFaceDirection(moveDirection : Vector2):
	if moveDirection.y < 0:
		_faceDirection = Vector2.UP
	elif moveDirection.y > 0:
		_faceDirection = Vector2.DOWN
	elif moveDirection.x > 0:
		_faceDirection = Vector2.RIGHT
	elif moveDirection.x < 0:
		_faceDirection = Vector2.LEFT
	pass

func SelectSpriteSet(isMoving : bool) -> int:
	var spriteSet = 0
	if _faceDirection == Vector2.UP:
		spriteSet = 3
	elif _faceDirection == Vector2.DOWN:
		spriteSet = 0
	elif _faceDirection == Vector2.RIGHT:
		spriteSet = 2
	elif _faceDirection == Vector2.LEFT:
		spriteSet = 1
	pass
	return spriteSet

func HandleSpriteFrame(delta, isMoving, spriteSet):
	var deltaProgress = 0
	if isMoving:
		deltaProgress = delta * RUNNING_ANIMATION_SPEED * _speedMultiplier * linear_velocity.length()
		_spriteProgress += deltaProgress
		_spriteProgress = fmod(_spriteProgress, 3)
		$Sprite.frame_coords.x = spriteSet * 3 + _spriteProgress
	else:
		$Sprite.frame_coords.x = spriteSet * 3

func HandleWrenchRotation():
	var player = get_tree().get_first_node_in_group("Player")
	
	var mousePosition = get_global_mouse_position()
	var screenCenter = player.get_viewport().size / 2.0
	var mouseRelativePosition = (mousePosition - screenCenter)
	var targetWrenchAngle = -mouseRelativePosition.angle_to(Vector2.LEFT)
	targetWrenchAngle += 1.25 * PI + PI
	var currentWrenchAngle = $Wrench.rotation
	var wrenchAngleDiff = fmod(targetWrenchAngle - currentWrenchAngle, 2 * PI) - PI
	$Wrench.apply_torque_impulse(wrenchAngleDiff * 50000 * $Wrench._postScale)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	var moveDirection = GetMoveDirection()
	HandleMovement(delta, moveDirection)
	HandleFaceDirection(moveDirection)
	var isMoving = moveDirection != Vector2()
	var spriteSet = SelectSpriteSet(isMoving)
	HandleSpriteFrame(delta, isMoving, spriteSet)
	HandleWrenchRotation()


func _on_hp_component_hp_reached_zero():
	await get_tree().create_timer(0.2).timeout
	visible = false
	$HitboxComponent/CollisionShape2D.disabled = true
	if $Wrench:
		$Wrench.queue_free()
	set_physics_process(false)
	emit_signal("playerDied")
	pass # Replace with function body.
