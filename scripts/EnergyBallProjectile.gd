extends Area2D

var speed = 750
@export var EnergyDamage = 50

func _ready():
	connect("area_entered",self.on_area_entered)
	collision_layer = 2
	collision_mask = 2
	pass # Replace with function body.

func _physics_process(delta):
	position += transform.x * speed * delta

func on_area_entered(area):
	if not area is HitboxComponent:
		return
	if not area.is_in_group("Player"):
		return
	
	area.damage(EnergyDamage)
	queue_free()
