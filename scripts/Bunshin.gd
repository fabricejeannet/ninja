extends Spell
class_name Bunshin

export var duration:int 
var character:KinematicBody2D

func cast(_character:KinematicBody2D, mouse_pointer:Vector2) -> void:
	
	character = _character
	var bunshin = $KinematicBody2D
	bunshin.position = character.sight.global_position

	
	var animation_player = $KinematicBody2D/APSmoke
	
	animation_player.play("SmokeBomb")
	yield(get_tree().create_timer(duration), "timeout")
	animation_player.play("SmokeBomb")
	yield(animation_player,"animation_finished")
	bunshin.visible = false
	call_deferred("free")
