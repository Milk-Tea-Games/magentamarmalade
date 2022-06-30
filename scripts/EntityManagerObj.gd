
class_name EntityManager, "res://assets/images/icon_EntityManager.png"

extends Manager

const CORE = preload("res://scripts/CoreLib.gd")

# Custom Signals

signal sentQuitRequest
signal sentMapSwapRequest(newmap)
# Custom Methods


# Player

# interaction
func handle_player_interact(result, entity): # Triggers on Player interact
	
	print("Player Interacted Successfully!")
	if result:
		print(name + " : " + result.collider.get_class() + " class was interacted with!")
		result.collider.on_interact(entity)
	else:
		print ("failedresult")

# overlap collision

func check_overlap():
	var _Player = get_node("Player")
	var _PlayerShape = _Player.get_shape()
	var shape_radius = _Player.get_shape_radius()
	var position = _PlayerShape.get_global_position()
	var siblings = get_parent().get_children()
	var close_siblings = []

	for n in siblings:
		var sibling_position = n._PhysicksBody.get_global_position()
		var sibling_radius = n._Shape.get_shape().get_radius()
		var distance = position.distance_to(sibling_position)
		if( (distance < (shape_radius + sibling_radius) ) && !n.is_in_group("player")):
			close_siblings.append(n)
	print(close_siblings)
	return close_siblings

# existence/init
func on_playerBeganExisting(playername):
	print("Manager: Player Exists!")
	pass

# Sibling: MapManager
func handle_map_swap(destination): # Triggers on entity mapswap request
	emit_signal("sentMapSwapRequest", destination)
	

# SYSTEM
func send_quit_notif(): # Triggers on entity quit request
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)




# Signal Connections



func connect_mapmanager_signals():
	connect("sentMapSwapRequest", get_parent().get_node("MapManager"), "swap_map", [])

func _ready():

	# Signal Connections

		# self

		# player
	#connect_to_sibling("MapManager", "sentMapSwapRequest","swap_map")

	pass

func _process(delta):
	#print(get_children().size())
	pass
