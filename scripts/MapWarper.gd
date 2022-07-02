class_name MapWarper, "res://assets/images/icon_teleporter.png"
extends StaticEntity

export var outbound = {
	"map" : "Chai_room",
	"station_id" : 1,
}

export var inbound = {
	"inbound_id" : 0,
	"facedir" : 1,
	"return_vector" : Vector2(100,100)

}
onready var _EntityManager = get_manager()

onready var _PhysicksBody = get_node(@'Decoration') # Decoration is a staticbody2d extending class and provides the only physics for this class
onready var _Decoration = _PhysicksBody
onready var _Shape = _Decoration.get_node("CollisionShape2D")


# Signals
signal sentMapSwapRequest
signal requestedPlayerTranspose
signal requestedRealignCamera

# Action

func on_interact(x):
	#request_map_swap()
	print("Mapwarper: My on_interact was called with parameter " + x + " !")

func on_overlap_player(): # Overlap callback
	request_map_warp()

# Map Exchange

func request_map_warp():

	emit_signal("sentMapSwapRequest", outbound.map)
	emit_signal("requestedPlayerTranspose", outbound.station_id)
	emit_signal("requestedRealignCamera")
	
func get_station_id(): # returns inbound id for use in warper-to-warper teleport
	return inbound.inbound_id()


# Builtins

func _ready():


	var _Manager = get_manager()


	# Groups
	#add_to_group("entity")
	add_to_group("interact")
	_Decoration.add_to_group("interact")


	# Signals
	connect("sentMapSwapRequest", _Manager, "handle_map_swap")
	connect("requestedPlayerTranspose", _Manager, "transpose_player")
	connect("requestedRealignCamera", _Manager, "realign_camera")

