extends RigidBody2D

var WEAPON_DAMAGE_BASE = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_trigger(area):
	if (area is HitboxComponent):
		
		var angular_magn = abs(angular_velocity)
		var MAX_MAGN = 14.0
		
		angular_magn = clamp(angular_magn,0, MAX_MAGN)
		var extraDmg = angular_magn / MAX_MAGN
		var finalDmg = (1 + extraDmg) * WEAPON_DAMAGE_BASE
		
		print("weapon did:", finalDmg, " damage.")
		area.damage(finalDmg)
