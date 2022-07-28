class_name Decoration, "res://assets/images/editor/icon_Decoration.png"

extends StaticBody2D


var _PhysicksBody : Object = self
var test : String = "I am a decoration"

func get_pos() -> Vector2:

	return get_global_position()



# Action

func on_interact(spec):
	
	get_parent().on_interact(spec)

# BUILTIN Functions

func _ready():
	pass
