extends Node2D
class_name StateMachine

var states : Dictionary = {}
var currentState : State

@export var initial_state : State
# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is State:
			states[child.id()] = child;
			child.OnTransition.connect(on_child_transition)
	if initial_state:
		initial_state.Enter()
		currentState = initial_state
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if currentState:
		currentState.Update(delta)

func _physics_process(delta):
	if currentState:
		currentState.Physics_Update(delta)

func on_child_transition(requester_state, new_state_id):
	if requester_state != currentState:
		return
	
	var new_state = states.get(new_state_id)
	if !new_state:
		return
	# Perform the Transition
	requester_state.Exit()
	new_state.Enter()
	currentState = new_state

func player_entered_vision(player):
	if currentState:
		currentState.PlayerEnteredDetectionArea(player)

func player_left_vision(player):
	if currentState:
		currentState.PlayerLeftDetectionArea(player)
