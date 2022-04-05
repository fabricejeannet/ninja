extends Spell
class_name Henge

export var duration:int = 5

func cast(character:KinematicBody2D, _mouse_pointer:Vector2) -> void:
	var logRB2D = $LogRB2D
	var sprite = $LogRB2D/Sprite
	var animation_player = $LogRB2D/AnimationPlayer
	
	print("Henge !")
	logRB2D.position = character.global_position
	animation_player.play("SmokeBomb")
	character.visible = false
	character.can_move = false
	sprite.visible = true

	yield(get_tree().create_timer(duration), "timeout")
	animation_player.play("SmokeBomb")
	sprite.visible = false
	character.can_move = true
	character.visible = true
	yield(animation_player,"animation_finished")
	call_deferred("queue_free")



