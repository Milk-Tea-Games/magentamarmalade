
class_name MapManager,"res://assets/images/editor/icon_MapManager.png"
extends Manager

var current_mapname: String setget set_mapname, get_mapname




# Signals

signal requestedFreeMapbound




func set_mapname(newmapname) -> void:

	current_mapname = newmapname

func get_mapname() -> String:

	return current_mapname




func load_map(mapname): # Loads map of mapname from disk if map is in maps folder, returns map node reference

	if !check_map_redundancy(mapname) :

		var map : Resource = load("res://scenes/levels/maps/" + mapname + ".tscn")

		if map:

			map = map.instance()
		#print(map.get_children())
		#remove_redundant_player(map)
			reparent_entities(map)

			return map




func add_map(map) -> void:

	if typeof(map) == TYPE_STRING: # Check if map is a string and load it into an instantiated node
		
		map = load_map(map)
	
	if map and typeof(map) == TYPE_OBJECT:

		add_child(map)
		set_mapname(map.name)
	



func free_map(map) -> void: # Removes map from SceneTree
	
	map.free()

	free_mapbound_entities()



func free_mapbound_entities(): # frees entities that cannot persist between mapswaps

	emit_signal("requestedFreeMapbound")



func swap_map(map) -> void: # Replaces map1 with map2 in the Mapmanager's childspace

	print("swapmap called")

	var oldmap : Object = get_node(get_mapname())
	
	if map and oldmap:

		var index : int = oldmap.get_index()

		free_map(oldmap)
		
		map = load_map(map)

		add_map(map)

		move_child(map, index)
	
	print(get_node(get_mapname()))




func reparent_entities(map) -> void: # Reorganizes map entities to expected placement under parent singletons

	var children : Array = map.get_children()
	var new_parent : Object = get_parent().get_node("EntityManager")#CORELIB.get_main(self).get_node("EntityManager")

	if new_parent and children:

		print(new_parent.get_name())

		for n in children:

			if n.is_in_group("entity"):

				if n.is_in_group("player"):		# These groups relate to entity destruction when map is swapped later

					n.add_to_group("persistent")

				else:

					n.add_to_group("mapbound")


				map.remove_child(n)

				new_parent.add_child(n)

				n.propagate_position_transform()
				



func get_map_by_name(mapname: String) -> Node: # returns map with name mapname if it exists

	return get_node(mapname)




func check_map_redundancy(mapname: String) -> bool: # returns true if map with name mapname already exists

	if CORELIB.get_child_by_name(self, mapname):
		
		return true
	
	else:

		return false
	



func get_current_mapname() -> String: # Returns current mapname as a string

	return current_mapname



func set_current_mapname(mapname) -> void: # Sets current mapname from string provided

	current_mapname = mapname



func get_current_map() -> Node:

	return get_node(get_current_mapname())

# TODO create map formatting functions

func get_map_children() -> Array:

	return get_node(get_mapname()).get_children()



func remove_redundant_player(mapinstance) -> void:

	if mapinstance.get_node("Player") and get_current_mapname():

		mapinstance.get_node("Player").free()




## Builtins

func _init():
	pass

func _ready():
	# Signals
	pass

func _process(_delta):
	#print(get_mapname())
	pass
