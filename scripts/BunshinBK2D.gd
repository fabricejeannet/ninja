extends KinematicBody2D

onready var animation_player = $AnimationPlayer

func _process(delta):
	position = get_parent().character.sight.global_position
	animation_player.play(get_parent().character.animation_player.current_animation)
