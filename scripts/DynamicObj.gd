
class_name DynamicEntity, "res://assets/images/icon_DynamicObj.png"

extends BaseObj


var power: int
var properties: Array
var velocity = Vector2(1,0)
const vectorZero = Vector2(0,0)
#const anim: array

#### CUSTOM METHODS

## health
func on_health_change():
	pass

## motion

# alters motion vector for smooth physics engine motion
func impulse_move():
	
	pass

# alters motion sharply for jerky physics engine motion
func dash_move():
	pass

func rand_vec():
	var neg1 = rand_range(-1,1)
	var neg2 = rand_range(-1,1)

	
	return Vector2(neg1,neg2)

## Internode

func find_facing_block():
	pass



# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

	# Group management
	add_to_group("dynamicentity")
	# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
