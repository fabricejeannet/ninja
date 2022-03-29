extends TileMap

onready var player = get_parent().get_node("Sasuke")

func _input(event):
	if event is InputEventMouseButton:
		player.cast(event.position)
