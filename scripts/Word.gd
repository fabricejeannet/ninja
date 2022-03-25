extends TileMap


func _ready():
	pass # Replace with function body.


func _input(event):
	if event is InputEventMouseButton:
		print("Mouse Click/Unclick at: ", event.position)
		
		$Sasuke.cast(event.position)
