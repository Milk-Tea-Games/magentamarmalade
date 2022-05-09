class_name BaseObj

extends Node2D

var form  = "null"
var dyntype = true
var visual = ""
var health = 1289 setget set_health, get_health
var audio = ""
const porosity: bool = true

## CUSTOM METHODS


# Light Interactions

# called when light interacts with object
func porosity_interact():
	pass

# Health

func set_health(newhealth):
	health = newhealth

func get_health():
	return health

func add_health(health_value):
	health =+ health_value

# Utility

func get_pos():
	return get_global_position()

# Transforms

func rotate_by(r):
	#var rot = get_rotation()
	#rot += r
	#set_rotation(rot)
	pass



# BUILTIN RUN FUNCTIONS

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("testa")
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
