extends Area2D

var speed = 750
@export var EnergyDamage = 50

var moveDir = Vector2.ZERO

var maxScale = 2.5

func _ready():
	connect("area_entered",self.on_area_entered)
	collision_layer = 2
	collision_mask = 2
	pass # Replace with function body.

func fire(dir: Vector2, spawnPos: Vector2):
	global_position = spawnPos
	moveDir = dir
	

func _physics_process(delta):
	translate(moveDir * speed * delta)
	var scaleIncrease = 100
	if(scale.x < maxScale):
		scale += Vector2.ONE * delta

func on_area_entered(area):
	if not area is HitboxComponent:
		return
	if not area.is_in_group("Player"):
		return
	
	area.damage(EnergyDamage)
	queue_free()
