extends Area2D

var speed = 750
@export var EnergyDamage = 15
var moveDir = Vector2.ZERO

var firstScaleLevel = 1.9
var secondScaleLevel = 2.7
var maxScale = 3.5

func _ready():
	connect("area_entered",self.on_area_entered)
	collision_layer = 2
	collision_mask = 2
	pass # Replace with function body.

func fire(dir: Vector2, spawnPos: Vector2):
	global_position = spawnPos
	moveDir = dir
	

func _physics_process(delta):
	if scale.x < firstScaleLevel:
		$"energy ball sprite".set_texture(preload("res://assets/energy_ball/energyball_first.png"))
	elif scale.x < secondScaleLevel:
		$"energy ball sprite".set_texture(preload("res://assets/energy_ball/energyball_mid.png"))
	elif scale.x < maxScale:
		$"energy ball sprite".set_texture(preload("res://assets/energy_ball/energyball_final.png"))
	
	translate(moveDir * speed * delta)
	if(scale.x < maxScale):
		scale += Vector2.ONE * delta

func on_area_entered(area):
	if not area is HitboxComponent:
		return
	if not area.is_in_group("Player"):
		return
	
	area.damage(EnergyDamage)
	queue_free()
