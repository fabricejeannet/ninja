extends Spell
class_name Henge

func cast(character:KinematicBody2D, mouse_pointer:Vector2) -> void:
	var logRB2D = $LogRB2D
	var hero = get_node("Sasuke")
	print("Henge !")
	logRB2D.position = character.global_position
	character.visible = false
	logRB2D.visible = true

	
