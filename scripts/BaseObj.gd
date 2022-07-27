class_name BaseObj

extends Node2D

const CORELIB = preload("res://scripts/CoreLib.gd")
const ManagerName = "EntityManager"
const MainName = CORELIB.GAME_SCENE_NAME
## CUSTOM METHODS


# Managers

func get_ancestor_by_name(node , name):
	if node and name:
		var current_ancestor : Node = node.get_parent()

		if current_ancestor: #

			var current_ancestor_name : String = current_ancestor.get_name()

			if current_ancestor_name == name:
				return current_ancestor
			else:
				return get_ancestor_by_name(current_ancestor, name)
		


func get_main():

	return get_ancestor_by_name(self,"GAME")



func get_manager():
	var _Main = get_main()
	
	if _Main.get_node(ManagerName):
		return get_node(ManagerName)



# Utility


func get_pos() -> Vector2: #TODO examine further difference between position and global position and reimplement
	return get_global_position()


func find_in_array(): #TODO actually write function
	pass		


func get_physicksbody(): # Returns primary physicsbody

	if self._PhysicksBody:

		return self._PhysicksBody

# Transforms

func defray_move_call() -> void : # Skips a single call of move_and_slide for the node's physicsbody

	var _PhysicksBody = get_physicksbody()

	if _PhysicksBody and _PhysicksBody.has_method("move_and_slide_checked"):

		_PhysicksBody.defray_move = true



func propagate_position_transform() -> void : # Corrects position of nodes children to be identical to parent
	#TODO implement in physicsbody2d process logic instead of haphazardly here

	var global_pos = self.get_global_position()

	var _PhysicksBody = self.get_physicksbody()

	if _PhysicksBody:

		
		_PhysicksBody.set_position(CORELIB.VECTOR_ZERO)

		_PhysicksBody.set_global_position(global_pos) #REVIEW potentially unnecessary

		defray_move_call()


func reposition_and_propagate(position : Vector2 = Vector2(0,0)) -> void :
	#TODO remove in accordance with reimplementation of above, physicsbody2d node logic can do this without needing outside rectification functions
	
	set_global_position(position)

	propagate_position_transform()

#TODO bulk grouping, bulk signal declaration, bulk connection functions
#TODO generic instantiation functions for reimplementation

# BUILTIN RUN FUNCTIONS

# Called when the node enters the scene tree for the first time.
func _init():
	add_to_group("entity")
	pass

func _ready():
	
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
