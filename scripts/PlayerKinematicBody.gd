
extends KinematicBody2D

# Global library
var CORELIB = MagentaLib.new()

# Constants

var InputMap : Array = CORELIB.InputMap
var InputVectors : Array = CORELIB.InputVectors
var VectorEnum : Array = CORELIB.VectorEnum
var MAX_SPEED : int = CORELIB.MAX_SPEED
var vectorZero : Vector2 = CORELIB.VECTOR_ZERO
var test = "PlayerObj"

# Class-Specific variables

var velocity : Vector2 = CORELIB.VECTOR_ZERO
var acceleration : int = 1000
var friction : int = 2
var facedir : String = "down"
var btndown : bool = false

var defray_move : bool = false


#warning-ignore: return_value_discarded

# Signals


func change_facedir(new_facedir) -> void:

	facedir = new_facedir

	var Parent : Node = get_parent()

	Parent.facedir = facedir

## Motion

func move_and_slide_checked(linear_vel : Vector2 , _up_dir : Vector2 = CORELIB.VECTOR_ZERO, _stop_on_slope : bool = false, _max_slides : int = 4, _floor_max_angle : float = 0.785398, _infinite_inertia : bool = false) -> void:

	# normal move and slide function, but with single-frame physics move call defray enabled

	if defray_move:

		defray_move = false

		return

	else:

		move_and_slide(linear_vel, _up_dir, _stop_on_slope, _max_slides, _floor_max_angle, _infinite_inertia)


func move_by_control() -> void:

	var movementResult: Vector2 = Vector2(0,0)

	for i in 4:

		var j = InputMap[i]

		if Input.is_action_pressed("ui_" + j):

			btndown = true

			change_facedir(j)

			var input_vec : Array = InputVectors[i]

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
