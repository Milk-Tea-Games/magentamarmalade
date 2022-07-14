class_name MagentaLib
extends Reference

# Constants
const MAINNODENAME = "GAME"
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


# Util

func player_interact():
	pass

func get_main(node):
	var main_name : String = node.get_tree().get_root().get_children()[0].get_name()
	var expected_name = MAINNODENAME
	if(main_name == expected_name):
		return node.get_tree().get_root().get_node(main_name)
	elif main_name == "Gut":
		var dest = node.get_tree().get_root().get_node(main_name)
		dest = dest.get_node("@@93/GAME")
		#dest = dest.get_node("GAME")
		return dest
