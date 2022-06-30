class_name Player, "res://assets/images/icon_Player.png"
extends DynamicEntity

# Global library
const CORE = preload("res://scripts/CoreLib.gd")

# Constants

const InputMap = CORE.InputMap
const InputVectors = CORE.InputVectors
const VectorEnum = CORE.VectorEnum
const MAX_SPEED = CORE.MAX_SPEED
const INTERACT_DISTANCE = CORE.INTERACT_DISTANCE
const test = "PlayerObj"

# Variables

var state := "idle"
var facedir := "down"
var btndown = null

# Child Nodes
onready var _PhysicksBody = $PhysicksBody
onready var _Shape = get_node(@'PhysicksBody/Shape')
onready var _Sprite = get_node(@'PhysicksBody/Sprite')
onready var _AreaBody = get_node(@'Area2D')
onready var _Animation_Player = $AnimationPlayer
onready var _Camera = get_node(@'PhysicksBody/Camera2D')
onready var _Manager = get_tree().get_root().get_node("GAME").get_node("EntityManager")
onready var _Particles = _PhysicksBody.get_node(@'CPUParticles2D')

# Physics vars
onready var space_state = get_world_2d().direct_space_state


# Signals

signal playerBeganExisting
signal playerInteracted
signal sentQuitRequest
signal sentMapSwapRequest




func connect_to_entitymanager():
	if(_Manager):
		_Manager.connect_player_signals()
### CUSTOM METHODS


# Wrappers

func get_pos(component = "Shape"):
	if component == "Sprite":
		return _Sprite.get_global_position()
	elif component == "PhysicksBody":
		return _PhysicksBody.get_global_position()
	else:
		return _Shape.get_global_position()


# Control

func send_quit_request():
	emit_signal("sentQuitRequest")
	print("quitattempt")



# Signal Functions

func connect_manager_signals(): # Establishes signal connections to Entity Manager for external communications
	connect("sentMapSwapRequest", _Manager, "handle_map_swap", [])
	connect("sentQuitRequest", _Manager, "send_quit_notif")
	connect("playerInteracted", _Manager, "handle_player_interact")
	connect("playerBeganExisting", _Manager, "on_playerBeganExisting", [])


## Motion


## Animation
func animate_by_velocity():
	velocity = _PhysicksBody.velocity
	var normalized_velocity = velocity.normalized()

	var dir = null
	match normalized_velocity:
		Vector2(-1,0):
			dir = InputMap[0]
		Vector2(1,0):
			dir = InputMap[1]
		Vector2(0,-1):
			dir = InputMap[2]
		Vector2(0,1):
			dir = InputMap[3]
	if dir:
		_Animation_Player.play("walk_" + dir)
	else:
		_Animation_Player.stop(true)


## action

func interact_entity():
	var direction_vector = InputVectors[VectorEnum[facedir]]
	direction_vector = Vector2(direction_vector[0],direction_vector[1])
	var endpoint = get_pos("Shape") + (direction_vector * INTERACT_DISTANCE)
	var result = space_state.intersect_ray(get_pos(), endpoint)
	if result and result.collider:
		if(result.collider.is_in_group("interact")):
			emit_signal("playerInteracted", result, name) # 
			print("player interacted")
	else:
		var newmap = "Chai_Room"
		var mainmap = "ASS_face"
		print("interact failed")
		##emit_signal("sentMapSwapRequest", mainmap, newmap)
	if(_Particles):
		var dirvec  = InputVectors[VectorEnum[facedir]]
		dirvec = Vector2(dirvec[0], dirvec[1]) * 100
		_Particles.set_direction(dirvec)
		_Particles.set_gravity(dirvec)

## Detection

func check_overlap():
	var shape_radius = _Shape.get_shape().get_radius()
	var position = _Shape.get_global_position()
	var siblings = get_parent().get_children()
	var close_siblings = []

	for n in siblings:
		var sibling_position = n._PhysicksBody.get_global_position()
		var sibling_radius = n._Shape.get_shape().get_radius()
		var distance = position.distance_to(sibling_position)
		if( (distance < (shape_radius + sibling_radius) ) && !n.is_in_group("player")):
			close_siblings.append(n)
	print(close_siblings)
	return close_siblings


func get_shape():
	return _Shape

func get_shape_radius():
	var radius : float = 0.0
	if(_Shape and _Shape.get_shape()):
		radius = _Shape.get_shape().get_radius()
	return radius
# BUILTIN Functions

func _ready():
	# Setup

	# Connections
	connect_manager_signals()

	# Outbound Signals

	emit_signal("playerBeganExisting", name)
	
	# Groupings
	add_to_group("dynamicentity")
	#add_to_group("entity")
	add_to_group("player")

	# Camera Setup

	_Camera.align()
	_Camera.make_current()
	pass # Replace with function body.

	
func _process(delta):
	animate_by_velocity()
	if Input.is_action_pressed("ui_interact"):
		interact_entity()
	elif Input.is_action_pressed("ui_cancel"):
		send_quit_request()
	
	check_overlap()

	#print(facedir)
	#print(InputVectors[VectorEnum[facedir]])
	
