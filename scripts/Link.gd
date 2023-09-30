extends RigidBody2D

var _faceDirection := Vector2.DOWN
var _spriteProgress := 0.0
const BASE_MOVEMENT_SPEED = 80000
const IDLE_ANIMATION_SPEED = 4
const RUNNING_ANIMATION_SPEED = 16
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

func SelectSpriteRow(isMoving : bool) -> int:
	var spriteRow = 0
	if _faceDirection == Vector2.UP:
		spriteRow = 2
	elif _faceDirection == Vector2.DOWN:
		spriteRow = 0
	elif _faceDirection == Vector2.RIGHT:
		spriteRow = 3
	elif _faceDirection == Vector2.LEFT:
		spriteRow = 1
	pass
	if isMoving:
		spriteRow += 4
	return spriteRow

func HandleSpriteFrame(delta, isMoving, spriteRow):
	var deltaProgress = 0
	if isMoving:
		deltaProgress = delta * RUNNING_ANIMATION_SPEED * _speedMultiplier
	else:
		deltaProgress = delta * IDLE_ANIMATION_SPEED * _speedMultiplier
	_spriteProgress += deltaProgress
	_spriteProgress = fmod(_spriteProgress, SPRITE_ROW_LIMITS[spriteRow])
	$Sprite.frame_coords.y = spriteRow
	$Sprite.frame_coords.x = _spriteProgress

func HandleWrenchRotation():
	var mousePosition = get_viewport().get_mouse_position()
	var screenCenter = get_viewport().size / 2.0
	var mouseRelativePosition = (mousePosition - screenCenter)
	var targetWrenchAngle = -mouseRelativePosition.angle_to(Vector2.LEFT)
	targetWrenchAngle += 1.25 * PI + PI
	var currentWrenchAngle = $Wrench.rotation
	var wrenchAngleDiff = fmod(targetWrenchAngle - currentWrenchAngle, 2 * PI) - PI
	$Wrench.apply_torque_impulse(wrenchAngleDiff * 12000)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	var moveDirection = GetMoveDirection()
	HandleMovement(delta, moveDirection)
	HandleFaceDirection(moveDirection)
	var isMoving = moveDirection != Vector2()
	var spriteRow = SelectSpriteRow(isMoving)
	HandleSpriteFrame(delta, isMoving, spriteRow)
	HandleWrenchRotation()
