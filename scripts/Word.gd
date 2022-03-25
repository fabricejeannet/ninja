extends TileMap

func _input(event):
	if event is InputEventMouseButton:
		$Sasuke.cast(event.position)
