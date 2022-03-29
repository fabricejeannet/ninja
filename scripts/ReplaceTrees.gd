extends TileMap

const SMALL_TREE = preload("res://scenes/SmallTree.tscn")

func _ready():
	for cellpos in get_used_cells():
		var cell = get_cellv(cellpos)
		if (cell == 0):
			var small_tree = SMALL_TREE.instance()
			small_tree.position = map_to_world(cellpos) * scale
			add_child(small_tree)
			set_cellv(cellpos, -1)
