extends Node2D

@export var Fish : PackedScene

var _overallPosition = Vector2()
const X_RANGE = 500
const Y_RANGE = 500
const RATE = 0.2
const FISH_COUNT = 50

var fishes1 = []
var fishes2 = []
var fishes3 = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in FISH_COUNT:
		var fish1 = Fish.instantiate()
		fish1.position = Vector2(1000 + randf() * 1000, 1000 + randf() * 1000)
		fish1.get_child(0).scale = Vector2(1,1) * (randf() + 0.5)
		fishes1.append(fish1)
		$ParallaxBackground/ParallaxLayer.add_child(fish1)
		
		var fish2 = Fish.instantiate()
		fish2.position = Vector2(1000 + randf() * 1000, 1000 + randf() * 1000)
		fish2.get_child(0).scale = Vector2(0.25, 0.25) * (randf() + 0.5)
		fishes2.append(fish2)
		$ParallaxBackground/ParallaxLayer2.add_child(fish2)
		
		var fish3 = Fish.instantiate()
		fish3.position = Vector2(1000 + randf() * 1000, 1000 + randf() * 1000)
		fish3.get_child(0).scale = Vector2(0.3, 0.3) * (randf() + 0.5)
		fishes3.append(fish3)
		$ParallaxBackground/ParallaxLayer3.add_child(fish3)

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
		var fish = fishes1[i]
		var diff = (_overallPosition - fish.position).rotated(randf()*0.8)
		fish.apply_impulse(diff.normalized() * randf() * 0.1)
		
		fish = fishes2[i]
		diff = (_overallPosition - fish.position).rotated(randf()*0.8)
		fish.apply_impulse(diff.normalized() * randf() * 0.15)
		
		fish = fishes3[i]
		diff = (_overallPosition - fish.position).rotated(randf()*0.8)
		fish.apply_impulse(diff.normalized() * randf() * 0.2)
	pass
