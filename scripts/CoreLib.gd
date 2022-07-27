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


func get_child_by_name(node, name): # returns child node with name name if found
	#TODO Make recursive full array search for children
	if node and name and typeof(node) == TYPE_OBJECT and typeof(name) == TYPE_STRING:
		
		var children = node.get_children()

		if children.size() > 0:
			for n in children:

				if n.get_name() == name:

					return n

# Scenetree Util

func get_ancestor_by_name(node , name):
	if node and name:
		
		var current_ancestor : Node = node.get_parent()

		if current_ancestor: #

			var current_ancestor_name : String = current_ancestor.get_name()

			if current_ancestor_name == name:
				return current_ancestor
			else:
				return get_ancestor_by_name(current_ancestor, name)



func player_interact():
	pass

func get_main(node):
	var main_name : String = node.get_tree().get_root().get_children()[0].get_name()
	var expected_name = GAME_SCENE_NAME
	if(main_name == expected_name):
		return node.get_tree().get_root().get_node(main_name)
	elif main_name == "Gut":
		var dest = node.get_tree().get_root().get_node(main_name)
		dest = dest.get_node("@@93/GAME")
		#dest = dest.get_node("GAME")
		return dest
