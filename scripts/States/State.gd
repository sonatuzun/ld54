extends Node2D
class_name State

signal OnTransition(requester_state: State, new_state: StateNames)

enum StateNames{
	Idle,
	MoveTowardsTarget,
	GuardArea
}

func id():
	pass
	
func Enter():
	pass

func Exit():
	pass
	
func Update(_delta: float):
	pass
	
func Physics_Update(_delta: float):
	pass

func PlayerEnteredDetectionArea(body):
	pass
	
func PlayerLeftDetectionArea(body):
	pass
