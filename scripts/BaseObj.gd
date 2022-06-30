class_name BaseObj

extends Node2D

var Parent : Node
## CUSTOM METHODS


# Health


# Utility

func get_pos():
	return get_global_position()

func propagate_position_transform(): # Corrects position of nodes children to be identical to parent
	if self._PhysicksBody:
		self._PhysicksBody.set_global_position(self.get_global_position())
# Transforms

func rotate_by(r):
	#var rot = get_rotation()
	#rot += r
	#set_rotation(rot)
	pass



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
