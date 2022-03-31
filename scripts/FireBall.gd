extends Spell
class_name FireBall

func cast(character:KinematicBody2D, mouse_pointer:Vector2) -> void:
	var kb2d = $KinematicBody2D
	kb2d.global_position = mouse_pointer
	kb2d.rotate(mouse_pointer.angle_to_point(character.global_position))
	kb2d.set_motion((mouse_pointer - character.global_position).normalized())
	kb2d.set_shot(true)
