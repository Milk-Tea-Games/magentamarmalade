

class_name StaticEntity, "res://assets/images/icon_StaticObj.png"

extends BaseObj

var intensity: int

# light_type - permanence of light ray for light objects
const light_type: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():

	add_to_group("staticentity")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
