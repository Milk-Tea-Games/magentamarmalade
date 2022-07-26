
class_name EntityManager, "res://assets/images/editor/icon_EntityManager.png"

extends Manager

# Custom Signals

signal sentQuitRequest
signal deliveredMapSwapRequest(newmap)
# Custom Methods


# Player

func transpose_player(value): # moves player to global Vector2 pos

	#REVIEW examine positioning caveats on kinematicbody

	var Player = get_player()
	var end_pos := Vector2(500,500)
	if Player:
		#print("THERE IS A VALUE")
		match typeof(value):
			TYPE_VECTOR2:
				end_pos = value
			TYPE_INT:
				if value < 2: # Internal node naming does not append 0 or 1 to identical node names # NB, implement a better solution to this bandage
					value = ""
				var Warper = get_node("MapWarper" + str(value))
				end_pos = Warper.get_position() + Warper.inbound.return_vector

	print(end_pos)
	Player.set_global_position(end_pos)
	Player.reverse_position_transform()

# interaction

func get_player():
	var Player = get_node("Player")
	return Player

func handle_player_interact(result, entity): # Triggers on Player interact
	
	print("Player Interacted Successfully!")
	if result:
		print(name + " : " + result.collider.get_class() + " class was interacted with!")
		result.collider.on_interact(entity)
	else:
		print ("failedresult")

func realign_camera():
	get_player().setup_camera()

# overlap collision

func check_overlap_player(): # checks for overlapping nodes and performs an overlap_interact if they do overlap
	var overlappers = get_player_overlaps()
	if(overlappers):
		call_on_overlaps(overlappers)



func call_on_overlaps(overlappers):	# calls overlap functions for any overlapping nodes
	
	if(overlappers && typeof(overlappers) == TYPE_ARRAY && overlappers.size() > 0):
		for n in overlappers:
			if n.on_overlap_player():
				n.overlap_player()


# existence/init
func on_playerBeganExisting():
	print("Manager: Player Exists!")
	pass

# Sibling: MapManager
func handle_map_swap(destination): # Triggers on entity mapswap request
# REVIEW examine use of signals here
	emit_signal("deliveredMapSwapRequest", destination)

func freeMapbound(): # Frees entities that cannot be held between maps
	var children = get_children()
	for n in children:
		if n.is_in_group("mapbound"):
			remove_child(n)
			n.queue_free()
			


# SYSTEM
func send_quit_notif(): # Triggers on entity quit request
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)




# Signal Connections



func connect_mapmanager_signals():
	var _MapManager = get_sibling("MapManager")
	connect("deliveredMapSwapRequest", get_parent().get_node("MapManager"), "swap_map")
	_MapManager.connect("requestedFreeMapbound", self, "freeMapbound")

func _ready():

	# SIGNAL CONNECTIONS

	# signals : self

	# signals : player

	# signals : siblings

	#connect_to_sibling("MapManager", "sentMapSwapRequest","swap_map")
	connect_mapmanager_signals()
	pass

func _process(delta):
	#print(get_children().size())
	pass
