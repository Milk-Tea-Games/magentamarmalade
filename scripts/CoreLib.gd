class_name MagentaLib
extends Reference

# Constants

const GAME_SCENE_NAME = "GAME"
const InputMap = ["left","right","up","down"]
const InputVectors = [[-1,0],[1,0],[0,-1],[0,1]]
enum VectorEnum {left,right,up,down}
const test = "CoreLib"
# Dynamic Object

const VECTOR_ZERO = Vector2(0,0)
const MAX_SPEED = 600 # 300 default

# Global singleton reference
var _Gameroot : Node


# Static Object


func group_self_as_dynamic():
	print(test)

# Player
const INTERACT_DISTANCE = 250


# UTIL

# Scenetree Util

func get_ancestor_by_name(node : Object, name : String):
	if node and name:
		
		var current_ancestor : Node = node.get_parent()

		if current_ancestor: #

			var current_ancestor_name : String = current_ancestor.get_name()

			if current_ancestor_name == name:
				return current_ancestor
			else:
				return get_ancestor_by_name(current_ancestor, name)


func get_main(node : Object):

	var main_name : String = node.get_tree().get_root().get_children()[0].get_name()

	var expected_name : String = GAME_SCENE_NAME

	if(main_name == expected_name):

		return node.get_tree().get_root().get_node(main_name)

	elif main_name == "Gut":

		var dest : Object = node.get_tree().get_root().get_node(main_name)

		dest = dest.get_node("@@93/GAME")
		#dest = dest.get_node("GAME")

		return dest


func get_ancestor_by_method(node : Object, methodname : String) -> Object: # searches personal tree until a node with the method is found or runs out of parents 
	
	var current_ancestor : Object = node.get_parent()

	if current_ancestor and current_ancestor.has_method(methodname):

		current_ancestor = current_ancestor

	else:

		return get_ancestor_by_method(node, methodname)

	return current_ancestor

