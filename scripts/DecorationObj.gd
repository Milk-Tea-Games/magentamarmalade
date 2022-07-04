class_name Decoration, "res://assets/images/icon_Decoration.png"

extends StaticBody2D


var _PhysicksBody = self
var test = "I am a decoration"
func get_pos():
	return get_global_position()



# Action

func on_interact(spec):
	get_parent().on_interact(spec)

# BUILTIN Functions

func _ready():
	add_to_group("entity")
	add_to_group("staticentitiy") # REVIEW candidacy for this group
