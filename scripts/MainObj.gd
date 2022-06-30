extends Node2D

var count: int = 0




# Signals


# Singleton Reference






# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	get_node("MapManager").add_map("ASP_face")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
