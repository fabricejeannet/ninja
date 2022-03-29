class_name Spell
extends KinematicBody2D


const MOTION_SPEED = 300 # Pixels/second.
export var cost:int = 15 setget set_cost, get_cost

var shot:bool = true setget set_shot, is_shot
var motion:Vector2

func _physics_process(delta):
	if is_shot():
		#warning-ignore:return_value_discarded
		var collision = move_and_collide(motion * MOTION_SPEED * delta)
		if collision:
			call_deferred("queue_free")

func get_cost() -> int:
	return cost


func set_cost(_cost:int) -> void :
	cost = _cost


func is_shot() -> bool :
	return shot


func set_shot(_shot:bool) -> void:
	shot = _shot


func set_motion(_motion:Vector2) -> void:
	motion = _motion
