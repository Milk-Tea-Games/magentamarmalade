
class_name TileMapIsoMM, "res://assets/images/editor/icon_TileMapIso.png"

extends TileMap

var CELL_SIZE = Vector2(32,16)


func _init():
	if Engine.editor_hint:
		set_mode(1)
		set_cell_size(CELL_SIZE)
	pass
