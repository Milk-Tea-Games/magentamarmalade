class_name Player, "res://assets/images/editor/icon_Player.png"
extends DynamicEntity

# Not Constants

var InputMap = CORELIB.InputMap
var InputVectors = CORELIB.InputVectors
var VectorEnum = CORELIB.VectorEnum
var MAX_SPEED = CORELIB.MAX_SPEED
var INTERACT_DISTANCE = CORELIB.INTERACT_DISTANCE
var test = "PlayerObj"




# Variables
var state := "idle" #TODO get rid of statemachine staging code
var facedir := "down"
var btndown = null

# Managing Nodes
onready var _MainObj = get_ancestor_by_name(self,"GAME")
onready var _Manager = _MainObj.get_node("EntityManager")#get_manager()#get_tree().get_root().get_node("GAME").get_node("EntityManager")


# Onready Variables
onready var Player_exists = _MainObj.Player_exists #REVIEW for more elegant signaling of playerexistence

# Child Nodes
onready var _PhysicksBody = $PhysicksBody
onready var _Shape = get_node(@'PhysicksBody/Shape')
onready var _Sprite = get_node(@'PhysicksBody/Sprite')
onready var _Animation_Player = $AnimationPlayer
onready var _Camera = get_node(@'PhysicksBody/Camera2D')
onready var _Particles #= _PhysicksBody.get_node(@'CPUParticles2D')

# Physics vars
onready var space_state = get_world_2d().direct_space_state


# Signals

signal playerBeganExisting
signal playerInteracted
signal sentQuitRequest
signal sentMapSwapRequest
signal playerCheckedOverlap




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



# Signal Functions

func connect_manager_signals(): # Establishes signal connections to Entity Manager for external communications
	# TODO make signals and connections run through parsed JSON.
	connect("sentMapSwapRequest", _Manager, "handle_map_swap", [])
	connect("sentQuitRequest", _Manager, "send_quit_notif")
	connect("playerInteracted", _Manager, "handle_player_interact")
	connect("playerBeganExisting", _Manager, "on_playerBeganExisting", [])
	connect("playerCheckedOverlap", _Manager, "check_overlap_player")


## Motion


## Animation

#TODO use animate by keypress instead of velocity
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

func swappies(): #TODO remove test function
	emit_signal("sentMapSwapRequest", "Chai_room")

func interact_entity():
	var direction_vector = InputVectors[VectorEnum[facedir]]
	direction_vector = Vector2(direction_vector[0],direction_vector[1])
	var endpoint = get_pos("Shape") + (direction_vector * INTERACT_DISTANCE) #TODO shorten interact range
	var result = space_state.intersect_ray(get_pos(), endpoint)
	if result and result.collider:
		if(result.collider.is_in_group("interact")):
			emit_signal("playerInteracted", result, name) # 
	else:
		pass
	if(_Particles):
		var dirvec  = InputVectors[VectorEnum[facedir]]
		dirvec = Vector2(dirvec[0], dirvec[1]) * 100
		_Particles.set_direction(dirvec)
		_Particles.set_gravity(dirvec)

## Detection

func check_overlap():
	emit_signal("playerCheckedOverlap")

func get_shape():
	return _Shape

func get_shape_radius():
	var radius : float = 0.0
	if(_Shape and _Shape.get_shape()):
		radius = _Shape.get_shape().get_radius()
	return radius


func avoid_redundancy():
	if Player_exists:
		queue_free()
	else:
		_MainObj.Player_exists = true
		Player_exists = true

func setup_camera():
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
	reverse_position_transform()
	if Input.is_action_pressed("ui_interact"):
		swappies()##interact_entity()
	elif Input.is_action_pressed("ui_cancel"):
		send_quit_request()
	
	check_overlap()
	#print(facedir)
	#print(InputVectors[VectorEnum[facedir]])
	
