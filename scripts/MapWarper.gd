class_name MapWarper, "res://assets/images/icon_teleporter.png"
extends StaticEntity

export var destination = {
	"map" : "Chai_Room",
	"position" : Vector2(40,40)
}

onready var _PhysicksBody = get_node(@'Decoration') # Decoration is a staticbody2d extending class and provides the only physics for this class
onready var _Decoration = _PhysicksBody
onready var _Shape = _Decoration.get_node("CollisionShape2D")
# Signals
signal requestedMapSwap

# Action

func on_interact(x):
	#request_map_swap()
	print("Mapwarper: My on_interact was called with parameter " + x + " !")

# Map Exchange

func request_map_swap():
	var Parent = get_parent()
	emit_signal("requestedMapSwap",destination)





# Builtins

func _ready():
	var Parent = get_parent()
	# Groups
	#add_to_group("entity")
	add_to_group("interact")
	_Decoration.add_to_group("interact")
	# Signals
	connect("requestedMapSwap", Parent, "handle_map_swap")

