extends RigidBody2D

var WEAPON_DAMAGE_BASE = 10

@onready var _weaponIconInitialPosition = $WeaponIcon.position
@onready var _headColliderInitialPosition = $HeadCollider.position
@onready var _bodyColliderInitialPosition = $BodyCollider.position
@onready var _hitTriggerInitialPosition = $HitTrigger.position

@onready var _weaponIconInitialScale = $WeaponIcon.scale
@onready var _headColliderInitialScale = $HeadCollider.scale
@onready var _bodyColliderInitialScale = $BodyCollider.scale
@onready var _hitTriggerInitialScale = $HitTrigger.scale

var _postScale = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_postScale += delta / 35
	var scaleVector = Vector2(delta, delta)
	$WeaponIcon.position = _weaponIconInitialPosition * _postScale
	$HeadCollider.position = _headColliderInitialPosition * _postScale 
	$BodyCollider.position = _bodyColliderInitialPosition * _postScale 
	$HitTrigger.position = _hitTriggerInitialPosition * _postScale 

	$WeaponIcon.scale = _weaponIconInitialScale * _postScale
	$HeadCollider.scale = _headColliderInitialScale * _postScale
	$BodyCollider.scale = _bodyColliderInitialScale * _postScale
	$HitTrigger.scale = _hitTriggerInitialScale * _postScale


func _on_trigger(area):
	if (area is HitboxComponent):
		
		var angular_magn = abs(angular_velocity)
		var MAX_MAGN = 14.0
		
		angular_magn = clamp(angular_magn,0, MAX_MAGN)
		var extraDmg = angular_magn / MAX_MAGN
		var finalDmg = (1 + extraDmg) * WEAPON_DAMAGE_BASE
		
		print("weapon did:", finalDmg, " damage.")
		area.damage(finalDmg)
