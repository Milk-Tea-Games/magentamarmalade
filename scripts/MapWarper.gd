class_name MapWarper, "res://assets/images/editor/icon_teleporter.png"
extends StaticEntity

export var outbound : Dictionary = {
	"map" : "Chai_room",
	"station_id" : 1,
}

export var inbound : Dictionary = {
	"inbound_id" : 0,
	"facedir" : 1,
	"return_vector" : Vector2(100,100)

}

onready var _EntityManager : Manager = get_manager()

onready var _PhysicksBody : Node = get_node("Decoration") # Decoration is a staticbody2d extending class and provides the only physics for this class
onready var _Decoration : Node = _PhysicksBody
onready var _Shape : Node = _PhysicksBody.get_node("CollisionShape2D")


# Signals
signal sentMapSwapRequest
signal requestedPlayerTranspose
signal requestedRealignCamera

# Action

func on_interact(x) -> void:
	#request_map_swap()
	print("Mapwarper: My on_interact was called with parameter " + x + " !")



func on_overlap_player() -> void: # Overlap callback

	request_map_warp()

# Map Exchange

func request_map_warp() -> void:

	#print("warp emit")
	emit_signal("sentMapSwapRequest", outbound.map)
	emit_signal("requestedPlayerTranspose", outbound.station_id)
	emit_signal("requestedRealignCamera")


func get_station_id() -> int: # returns inbound id for use in warper-to-warper teleport

	return inbound.inbound_id


# Builtins

func _ready():


	var _Manager : Manager = get_parent().get_parent().get_node("EntityManager")
	# Groups
	#add_to_group("entity")
	add_to_group("interact")
	_Decoration.add_to_group("interact")


	# Signals
	connect("sentMapSwapRequest", _Manager, "handle_map_swap")
	connect("requestedPlayerTranspose", _Manager, "transpose_player")
	connect("requestedRealignCamera", _Manager, "realign_camera")

