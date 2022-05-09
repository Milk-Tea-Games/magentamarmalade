class_name Player, "res://assets/images/icon_Player.png"
extends KinematicBody2D

# Global library
const CORE = preload("res://scripts/CoreLib.gd")

# Constants

const InputMap = CORE.InputMap
const InputVectors = CORE.InputVectors
const VectorEnum = CORE.VectorEnum
const MAX_SPEED = CORE.MAX_SPEED
const INTERACT_DISTANCE = CORE.INTERACT_DISTANCE
const test = "PlayerObj"
# Class-Specific variables

var velocity = CORE.VECTOR_ZERO
var acceleration = 1000
var friction = 2
var facedir = "down"
var btndown = null

# Child Nodes
onready var _Shape = $Shape
onready var _Sprite = $Sprite
onready var _Animation_Player = $AnimationPlayer
onready var _Camera = get_node("Camera2D")
onready var _Entity_Manager = get_tree().get_root().get_node("GAME").get_node("EntityManager")

# Physics vars
onready var space_state = get_world_2d().direct_space_state


# Signals

signal playerInteracted

### CUSTOM METHODS

# Wrappers

func get_pos(component = "Shape"):
	if component == "Sprite":
		return _Sprite.get_global_position()
	elif component == "KinematicBody2D" or component == "Physicsbody":
		return get_global_position()
	else:
		return _Shape.get_global_position()

## Motion

func move_by_control():
	var movementResult: Vector2 = Vector2(0,0)

	for i in 4:
		var j = InputMap[i]
		if Input.is_action_pressed("ui_" + j):
			btndown = true
			facedir = j
			var input_vec = InputVectors[i]
			movementResult = Vector2(input_vec[0],input_vec[1])
			movementResult *= acceleration
			velocity += movementResult
	if movementResult == CORE.VECTOR_ZERO:

		if velocity.length() < 1:
			velocity = CORE.VECTOR_ZERO
		else:
			velocity /= friction

	velocity = velocity.clamped(MAX_SPEED)
	


func animate_by_velocity():
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
	if(result.collider.is_in_group("interact")):
		emit_signal("playerInteracted", result, name)



# BUILTIN Functions

func _ready():
	# Setup

	add_to_group("dynamicentity")
	add_to_group("entity")
	add_to_group("player")


	# Signal Interactions


	# Camera

	_Camera._set_current(true)


	pass # Replace with function body.

func _physics_process(delta):
	move_by_control()
	move_and_slide(velocity)
	#test.set_health(get_position().y)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	animate_by_velocity()
	if Input.is_action_pressed("ui_interact"):
		interact_entity()
#	pass
