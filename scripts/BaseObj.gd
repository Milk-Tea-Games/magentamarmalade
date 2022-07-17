class_name BaseObj

extends Node2D

const CORELIB = preload("res://scripts/CoreLib.gd")
const ManagerName = "EntityManager"
## CUSTOM METHODS


# Health




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



func get_pos(): #TODO examine further difference between position and global position and reimplement
	return get_global_position()

func find_in_array(): #TODO actually write function
	pass		



# Transforms

func propagate_position_transform(): # Corrects position of nodes children to be identical to parent
	#TODO implement in physicsbody2d process logic instead of haphazardly here
	if self._PhysicksBody:
		self._PhysicksBody.set_global_position(self.get_global_position())

func reverse_position_transform():
	#TODO remove in accordance with reimplementation of above, physicsbody2d node logic can do this without needing outside rectification functions
	if self._PhysicksBody:
		var pos = self._PhysicksBody.get_global_position()
		self.set_global_position(pos)
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
