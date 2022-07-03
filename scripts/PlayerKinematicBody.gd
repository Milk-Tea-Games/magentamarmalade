
extends KinematicBody2D

# Global library
const CORE = preload("res://scripts/CoreLib.gd")

# Constants

const InputMap = CORE.InputMap
const InputVectors = CORE.InputVectors
const VectorEnum = CORE.VectorEnum
const MAX_SPEED = CORE.MAX_SPEED
const vectorZero = CORE.VECTOR_ZERO
const test = "PlayerObj"
# Class-Specific variables

var velocity = CORE.VECTOR_ZERO
var acceleration = 1000
var friction = 2
var facedir = "down"
var btndown = null



# Signals


func change_facedir(new_facedir):
	facedir = new_facedir
	var Parent = get_parent()
	Parent.facedir = facedir

## Motion

func move_by_control():
	var movementResult: Vector2 = Vector2(0,0)

	for i in 4:
		var j = InputMap[i]
		if Input.is_action_pressed("ui_" + j):
			btndown = true
			change_facedir(j)
			var input_vec = InputVectors[i]
			movementResult = Vector2(input_vec[0],input_vec[1])
			movementResult *= acceleration
			velocity += movementResult
	if movementResult == vectorZero:

		if velocity.length() < 1:
			velocity = vectorZero
		else:
			velocity /= friction

	velocity = velocity.clamped(MAX_SPEED)


# BUILTIN Functions
func _ready():
	pass

func _physics_process(delta):
	move_by_control()
	move_and_slide(velocity)
	#test.set_health(get_position().y)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass