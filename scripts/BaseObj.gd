class_name BaseObj

extends Node2D

const CORELIB = preload("res://scripts/CoreLib.gd")
const ManagerName = "EntityManager"
const MainName = CORELIB.GAME_SCENE_NAME

var area_overlaps = []
## CUSTOM METHODS

# Signals

signal interact_overlapped


# Managers



func get_manager():
	var _Main = get_main()
	
	if _Main.get_node(ManagerName):
		return get_node(ManagerName)



# Utility

func get_main():

	return get_ancestor_by_name(self,"GAME")



func get_lineage(node) -> String:
	return node.get_path()



func get_pos() -> Vector2: #TODO examine further difference between position and global position and reimplement
	return get_global_position()



func find_in_array(): #TODO actually write function
	pass		



func get_ancestor_by_name(node , name):
	if node and name:
		var current_ancestor : Node = node.get_parent()

		if current_ancestor: #

			var current_ancestor_name : String = current_ancestor.get_name()

			if current_ancestor_name == name:
				return current_ancestor
			else:
				return get_ancestor_by_name(current_ancestor, name)



func get_ancestor_by_method(node : Object, methodname : String) -> Object: # searches personal tree until a node with the method is found or runs out of parents 

	var current_ancestor = node.get_parent()

	if current_ancestor and current_ancestor.has_method(methodname):

		current_ancestor = current_ancestor

	else:

		return get_ancestor_by_method(node, methodname)

	return current_ancestor



func get_physicksbody(): # Returns primary physicsbody

	if self._PhysicksBody:

		return self._PhysicksBody



func get_areabody():

	if get_node("Area2D"):

		var _AreaBody : Node = get_node("Area2D")
		
		return _AreaBody


# Transforms

func defray_move_call() -> void : # Skips a single call of move_and_slide for the node's physicsbody

	var _PhysicksBody : Node = get_physicksbody()

	if _PhysicksBody and _PhysicksBody.has_method("move_and_slide_checked"):

		_PhysicksBody.defray_move = true



func propagate_position_transform() -> void : # Corrects position of nodes children to be identical to parent
	#TODO implement in physicsbody2d process logic instead of haphazardly here

	var global_pos : Vector2 = self.get_global_position()

	var _PhysicksBody : Node = self.get_physicksbody()

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

# Detection

func get_overlaps() -> Array: # returns an array of all overlapping area2ds

	var overlapping_areas : Array = []

	if get_areabody():

		var _AreaBody : Node = get_areabody()

		overlapping_areas = _AreaBody.get_overlapping_areas()
	
	return overlapping_areas

		
func check_overlaps() -> void:

	var overlaps : Array = get_overlaps()

	for n in overlaps:

		var area_parent : Object = n.get_parent()

		if get_ancestor_by_method(self, "on_interact") :

			area_parent = get_ancestor_by_method(self, "on_interact")

			var lineage : String = area_parent.get_lineage() || area_parent.get_path()
			
			emit_signal("interact_overlapped", lineage) #TODO connection

			



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
