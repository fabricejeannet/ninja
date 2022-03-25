class_name Spell
extends KinematicBody2D


const MOTION_SPEED = 300 # Pixels/second.
export var cost:int = 15 setget set_cost, get_cost

var shot:bool = true setget set_shot, is_shot
var motion:Vector2
var animation_player:AnimationPlayer


func _ready():
	 animation_player = get_node("SpellAnimationPlayer")

func _process(delta):
	if !is_shot():
		look_at(get_global_mouse_position())


func _physics_process(delta):
	if is_shot():
		move_and_collide(motion * MOTION_SPEED * delta)


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

func get_animation_player() -> AnimationPlayer:
	return animation_player
