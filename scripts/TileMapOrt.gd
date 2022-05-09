tool
class_name TileMapOrtMM, "res://assets/images/icon_TileMapOrt.png"

extends TileMap

const CELL_SIZE = Vector2(32,32)

func _init():
	set_cell_size(CELL_SIZE)
