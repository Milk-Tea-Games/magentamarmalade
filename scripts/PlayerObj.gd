class_name Player, "res://assets/images/editor/icon_Player.png"
extends DynamicEntity

# Not Constants

var InputMap : Array = CORELIB.InputMap
var InputVectors : Array = CORELIB.InputVectors
var VectorEnum : Dictionary = CORELIB.VectorEnum
var MAX_SPEED : int = CORELIB.MAX_SPEED
var INTERACT_DISTANCE : int = CORELIB.INTERACT_DISTANCE
var test = "PlayerObj"




# Variables
var facedir : String = "down"
var btndown : bool = false

# Managing Nodes
onready var _MainObj : Node = get_ancestor_by_name(self,"GAME")
onready var _Manager : Manager = _MainObj.get_node("EntityManager")#get_manager()#get_tree().get_root().get_node("GAME").get_node("EntityManager")


# Onready Variables
onready var Player_exists : bool = _MainObj.Player_exists #REVIEW for more elegant signaling of playerexistence

# Child Nodes
onready var _PhysicksBody : Node = $PhysicksBody
onready var _Shape : Node = get_node(@'PhysicksBody/Shape')
onready var _Sprite : Sprite = get_node(@'PhysicksBody/Sprite')
onready var _Animation_Player : Node = $AnimationPlayer
onready var _Camera : Camera2D = get_node(@'PhysicksBody/Camera2D')
onready var _Area : Area2D = $Area2D
onready var _Particles
# Physics vars
onready var space_state : Physics2DDirectSpaceState = get_world_2d().direct_space_state


# Signals

signal playerBeganExisting
signal playerInteracted
signal sentQuitRequest
signal sentMapSwapRequest
signal playerCheckedOverlap




func connect_to_entitymanager() -> void:

	if(_Manager):

		_Manager.connect_player_signals()
### CUSTOM METHODS


# Wrappers

func get_pos(component = "Shape") -> Vector2:

	if component == "Sprite":

		return _Sprite.get_global_position()

	elif component == "PhysicksBody":

		return _PhysicksBody.get_global_position()

	else:

		return _Shape.get_global_position()


# Control

func send_quit_request() -> void:

	emit_signal("sentQuitRequest")



# Signal Functions

func connect_manager_signals() -> void: # Establishes signal connections to Entity Manager for external communications

	# TODO make signals and connections run through parsed JSON.

	connect("sentMapSwapRequest", _Manager, "handle_map_swap", [])

	connect("sentQuitRequest", _Manager, "send_quit_notif")

	connect("playerInteracted", _Manager, "handle_player_interact")

	connect("playerBeganExisting", _Manager, "on_playerBeganExisting", [])

	connect("playerCheckedOverlap", _Manager, "check_overlap_player")


## Motion


## Animation

#TODO use animate by keypress instead of velocity
func animate_by_velocity() -> void:

	var velocity : Vector2 = _PhysicksBody.velocity

	var normalized_velocity : Vector2 = velocity.normalized()

	var dir : String 

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

func swappies() -> void: #TODO remove test function

	emit_signal("sentMapSwapRequest", "Chai_room")


func interact_entity():

	var direction_vector : Vector2 = InputVectors[VectorEnum[facedir]]

	direction_vector = Vector2(direction_vector[0],direction_vector[1])

	var endpoint : Vector2 = get_pos("Shape") + (direction_vector * INTERACT_DISTANCE) #TODO shorten interact range

	var result : Dictionary = space_state.intersect_ray(get_pos(), endpoint)

	if result and result.collider:

		if(result.collider.is_in_group("interact")):

			emit_signal("playerInteracted", result, name) # 

	else:

		pass

	if(_Particles):

		var dirvec : Vector2 = InputVectors[VectorEnum[facedir]]

		dirvec = Vector2(dirvec[0], dirvec[1]) * 100

		_Particles.set_direction(dirvec)

		_Particles.set_gravity(dirvec)

## Detection


func check_overlap() -> void:

	emit_signal("playerCheckedOverlap")



func get_shape() -> Node:

	return _Shape



func get_shape_radius() -> float:

	var radius : float = 0.0

	if(_Shape and _Shape.get_shape()):

		radius = _Shape.get_shape().get_radius()

	return radius



func avoid_redundancy() -> void:

	if Player_exists:

		queue_free()

	else:

		_MainObj.Player_exists = true

		Player_exists = true



func setup_camera() -> void:

	if _Camera:

		_Camera.align()

		_Camera.make_current()

# BUILTIN Functions

func _init():

	set_name("Player")
# Groupings
	#add_to_group("entity")
	add_to_group("player")


func _ready():
	# Setup
	# Connections
	connect_manager_signals()

	# Outbound Signals

	emit_signal("playerBeganExisting")
	
	

	# Camera Setup
	setup_camera()
	
	pass # Replace with function body.

	
func _process(delta):

	animate_by_velocity()

	#reverse_position_transform()
	if Input.is_action_pressed("ui_interact"):

		swappies()##interact_entity()

	elif Input.is_action_pressed("ui_cancel"):

		send_quit_request()


	print(get_global_position())
	print(_PhysicksBody.get_global_position())
	
	check_overlap()
	#print(facedir)
	#print(InputVectors[VectorEnum[facedir]])
	
