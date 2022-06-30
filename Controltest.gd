extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ticker = 0
onready var children = get_children()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ticker += 0.1
	var sinoff = 0
	for i in children:
		sinoff += 30
		i.set_margin(1, sin(ticker + sinoff)*10)
		i.set_size(Vector2(100,30))
	pass
