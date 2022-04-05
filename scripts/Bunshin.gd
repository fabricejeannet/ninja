extends Spell
class_name Bunshin

var character:KinematicBody2D
var smoke:KinematicBody2D
var bunshin:KinematicBody2D
var animation_player:AnimationPlayer
var position_offset:Vector2

export var duration:int 
export var position_offset_coeff:Vector2

func cast(_character:KinematicBody2D, _mouse_pointer:Vector2) -> void:
	
	character = _character
	bunshin = $KinematicBody2D
	position_offset =  (character.sight.global_position - character.global_position) * position_offset_coeff

	smoke = $SmokeKB2D
	smoke.position = bunshin.position
	animation_player = $SmokeKB2D/APSmoke
	animation_player.play("SmokeBomb")
	if duration > 0:
		yield(get_tree().create_timer(duration), "timeout")
		destroy()
	

func destroy() -> void :
	smoke.position = bunshin.position
	bunshin.visible = false
	animation_player.play("SmokeBomb")
	yield(animation_player,"animation_finished")

	call_deferred("free")

func _process(_delta):
	bunshin.position = character.position + position_offset
