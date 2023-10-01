extends Node2D
class_name HpComponent

signal damageTaken

@export var healthBar: ProgressBar
@export var INITIAL_HP := 30
var curr_hp = 0.0
var isHpBarSetted: bool = false
signal hpReachedZero

# Called when the node enters the scene tree for the first time.
func _ready():
	curr_hp = INITIAL_HP
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	setHpBar()
	
func setHpBar():
	if healthBar && !isHpBarSetted:
		isHpBarSetted = true
		healthBar.min_value = 0.0
		healthBar.max_value = INITIAL_HP
		healthBar.value = curr_hp

func take_damage(amount):
	curr_hp -= amount
	
	if healthBar:
		healthBar.value = curr_hp
	
	emit_signal("damageTaken")
	if(curr_hp <= 0):
		emit_signal("hpReachedZero")
