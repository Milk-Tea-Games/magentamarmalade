class_name BaseObj

extends Node2D

var Parent : Node
## CUSTOM METHODS


# Health




# Managers
func get_main():
	return get_tree().get_root().get_node("GAME")

func get_manager():
	return get_main().get_node("EntityManager")

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

func rotate_by(r):
	#var rot = get_rotation()
	#rot += r
	#set_rotation(rot)
	pass


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
