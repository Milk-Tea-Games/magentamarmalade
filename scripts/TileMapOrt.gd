class_name TileMapOrtMM, "res://assets/images/editor/icon_TileMapOrt.png"

extends TileMap

const CELL_SIZE : Vector2 = Vector2(32,32)

func _init():
	set_cell_size(CELL_SIZE)
