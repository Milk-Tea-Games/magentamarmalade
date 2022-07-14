class_name MainObj
extends Node

var count: int = 0
var Player_exists = false



# Signals


# Singleton Reference


#TODO child singleton fetch functions
#TODO clock function


# BUILTINS

func _ready():
	#randomize()
	var _EntityManager = EntityManager.new()
	_EntityManager.set_name("EntityManager")
	var _MapManager = MapManager.new()
	_MapManager.set_name("MapManager")
	#
	add_child(_MapManager)
	add_child(_EntityManager)

	get_node("MapManager").add_map("ASP_face")
	#print(get_tree().get_root().get_children()[0].get_name())
	pass
func _process(_delta):

	pass
