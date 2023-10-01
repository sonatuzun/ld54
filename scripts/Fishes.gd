extends Node2D

var _overallPosition = Vector2()
const X_RANGE = 500
const Y_RANGE = 500
const RATE = 0.5
const FISH_COUNT = 1000

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in FISH_COUNT - 1:
		$Fish.position = Vector2(randf()*100,randf()*100)
		add_child($Fish.duplicate())

func FindOverallPosition(time : float):
	var x = sin(time*1.02*RATE) * X_RANGE
	var y = cos(time*1.06*RATE) * Y_RANGE
	return Vector2(x,y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	var time = Time.get_unix_time_from_system()
	_overallPosition = FindOverallPosition(time)
	for i in FISH_COUNT:
		var fish = get_child(i)
		var diff = (_overallPosition - fish.position).rotated(randf()*0.8)
		fish.apply_impulse(diff.normalized() * randf() * 0.1)
		fish.get_child(0).rotation = fish.linear_velocity.angle()
	pass
