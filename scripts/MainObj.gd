extends Node

var count: int = 0
var Player_exists = false



# Signals


# Singleton Reference






# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	get_node("MapManager").add_map("ASP_face")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):

	pass
