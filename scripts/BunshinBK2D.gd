extends KinematicBody2D

onready var animation_player = $AnimationPlayer

func _process(_delta):
	animation_player.play(get_parent().character.animation_player.current_animation)
