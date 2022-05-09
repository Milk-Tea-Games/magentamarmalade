extends Node2D

var count: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(count == 60):
		#print(get_tree().get_root().get_node("GAME").get_children())
		count = 0
	else:
		count += 1
