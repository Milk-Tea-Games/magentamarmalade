
class_name MapManager,"res://assets/images/icon_MapManager.png"
extends Manager

var current_mapname: String =  "ASP_face"

func load_map(mapname): # Loads map of mapname from disk if map is in maps folder, returns map node reference
	var map = load("res://resources/maps/" + mapname + ".tscn")
	map = map.instance()
	reparent_entities(map)
	return map
	pass


func add_map(map):
	if typeof(map) == 4: # Check if map is a string and load it into an instantiated node
		map = load_map(map)
	add_child(map)
	

func free_map(map): # Removes map from SceneTree
	map.queue_free()
	pass

func swap_map(map2, map1): # Replaces map1 with map2 in the Mapmanager's childspace
	
	if typeof(map1) == 17:
		map1 = map1
	elif typeof(map1) == 4:
		map1 = get_node(map1)
	else:
		map1 = get_node(get_current_mapname())
		
	map2 = load_map(map2)
	if map2 and map1:
		var index = map1.get_index()
		#free_map(map1)
		add_map(map2)
		move_child(map2, index)
		free_map(map1)
	pass

func reparent_entities(map): # Reorganizes map entities to expected placement under parent singletons
	var children = map.get_children()
	if children:
		var new_parent = get_tree().get_root().get_node("GAME").get_node("EntityManager")
		print(new_parent.get_name())
		for n in children:
			if n.is_in_group("entity"):
				map.remove_child(n)
				new_parent.add_child(n)
				n.propagate_position_transform()
				


func get_current_mapname(): # Returns current mapname as a string
	return current_mapname

func set_current_map(mapname): # Sets current mapname from string provided
	current_mapname = mapname

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

func connect_children():
	
	pass










## Builtins

func _init():
	pass

func _ready():
	# Signals
	
	pass

