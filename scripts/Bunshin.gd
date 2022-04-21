extends Spell
class_name Bunshin

export var duration:int 
export var position_offset_coeff:Vector2

var character:KinematicBody2D
var smoke:KinematicBody2D
var bunshin:KinematicBody2D
var animation_player:AnimationPlayer
var position_offset:Vector2

onready var Sasuke = load ("res://scenes/Sasuke.tscn")

func cast(_character:KinematicBody2D, _mouse_pointer:Vector2) -> void:
	
	character = _character
	bunshin = Sasuke.instance()

	position_offset =  (character.sight.global_position - character.global_position) * position_offset_coeff
	bunshin.position = character.global_position + position_offset

	smoke = $SmokeKB2D
	smoke.position = bunshin.position
	animation_player = $SmokeKB2D/APSmoke
	animation_player.play("SmokeBomb")
	
	character.get_parent().add_child(bunshin)
	bunshin.set_focus(true)
	character.set_focus(false)
	
	if duration > 0:
		yield(get_tree().create_timer(duration), "timeout")
		destroy()
	

func destroy() -> void :
	smoke.position = bunshin.position
	bunshin.visible = false
	animation_player.play("SmokeBomb")
	bunshin.set_focus(false)
	character.set_focus(true)
	yield(animation_player,"animation_finished")
	call_deferred("free")
