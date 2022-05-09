class_name Decoration, "res://assets/images/icon_Decoration.png"

extends StaticBody2D

var poop = "koyasu"
func get_pos():
	return get_global_position()


func on_interact(name):
	print(name + " made some amazing " + poop)

func _ready():
	add_to_group("entity")
	add_to_group("staticentitiy")
	add_to_group("interact")
