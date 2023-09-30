extends Area2D
class_name HurtBox

@export var damage = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	collision_layer = 2
	collision_mask = 2
	connect("area_entered",self.on_area_entered)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_area_entered(area):
	if not area is HitboxComponent:
		return
	
	if not area.is_in_group("Player"):
		return
	
	area.damage(damage)
