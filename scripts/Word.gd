extends TileMap

onready var player = get_parent().get_node("YSort/Sasuke")

func _input(event):
	if event is InputEventMouseButton:
		player.cast(event.global_position)
