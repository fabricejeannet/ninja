extends KinematicBody2D
class_name FireBallKB2D

const MOTION_SPEED = 300 # Pixels/second.
var shot:bool = false setget set_shot, is_shot
var motion:Vector2
var animation_player


func _physics_process(delta):
	if is_shot():
		#warning-ignore:return_value_discarded
		var collision = move_and_collide(motion * MOTION_SPEED * delta)
		if collision :
			call_deferred("queue_free")


func is_shot() -> bool :
	return shot


func set_shot(_shot:bool) -> void:
	shot = _shot


func set_motion(_motion:Vector2) -> void:
	motion = _motion
