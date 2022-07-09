
class_name MapManager,"res://assets/images/editor/icon_MapManager.png"
extends Manager

var current_mapname: String =  "ASP_face" setget set_mapname, get_mapname




# Signals

signal requestedFreeMapbound

func set_mapname(newmapname):
	current_mapname = newmapname

func get_mapname():
	return current_mapname

func load_map(mapname): # Loads map of mapname from disk if map is in maps folder, returns map node reference

	if !check_map_redundancy(mapname) :

		var map = load("res://resources/maps/" + mapname + ".tscn")
		map = map.instance()
		#print(map.get_children())
		remove_redundant_player(map)
		reparent_entities(map)

		return map


func add_map(map):

	if typeof(map) == 4: # Check if map is a string and load it into an instantiated node
		map = load_map(map)

	add_child(map)
	set_mapname(map.name)
	

func free_map(map): # Removes map from SceneTree
	
	map.queue_free()
	free_mapbound_entities()

func free_mapbound_entities(): # frees entities that cannot persist between mapswaps
	emit_signal("requestedFreeMapbound")


func swap_map(map): # Replaces map1 with map2 in the Mapmanager's childspace
	
	var oldmap = get_node(get_mapname())
	
	if map and oldmap:

		var index = oldmap.get_index()
		free_map(oldmap)
		
		map = load_map(map)
		add_map(map)
		move_child(map, index)
	
	print(get_node(get_mapname()))


func reparent_entities(map): # Reorganizes map entities to expected placement under parent singletons

	var children = map.get_children()

	if children:

		var new_parent = get_tree().get_root().get_node("GAME").get_node("EntityManager")
		print(new_parent.get_name())

		for n in children:

			if n.is_in_group("entity"):

				if n.is_in_group("player"):
					add_to_group("persistent")
				else:
					n.add_to_group("mapbound")

				map.remove_child(n)
				new_parent.add_child(n)
				n.propagate_position_transform()
				

func get_map_by_name(mapname: String) -> Node: # returns map with name mapname if it exists

	return get_node(mapname)


func check_map_redundancy(mapname: String): # returns true if map with name mapname already exists

	if get_node(mapname):
		
		return true
	

func get_current_mapname(): # Returns current mapname as a string

	return current_mapname

func set_current_mapname(mapname): # Sets current mapname from string provided

	current_mapname = mapname

func get_current_map():
	return get_node(get_current_mapname())


func get_map_index():
	pass

func get_map_indices(): # Returns a dictionary of collected maps with their indices

	var children = get_children()
	var collated_indices = {}

	for n in children:
		collated_indices[n.get_name()] = n.get_index()
	return collated_indices

func juxtapose_maps(map1,map2): # Exchanges positions between nodes map1 and map2

	var index1 = map1.get_index()
	var index2 = map2.get_index()

	if index1 and index2:

		move_child(map1, index2)
		move_child(map2, index1)

func get_map_children():
	return get_node(get_mapname()).get_children()

func remove_redundant_player(mapinstance):
	if mapinstance.get_node("Player") and get_current_map():
		mapinstance.get_node("Player").queue_free()








## Builtins

func _init():
	pass

func _ready():
	# Signals

	connect("requestedFreeMapbound", get_sibling("EntityManager"), "freeMapbound")
	pass

func _process(_delta):
	#print(get_mapname())
	pass
