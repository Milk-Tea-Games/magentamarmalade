extends KinematicBody2D

var parent = get_parent()

var velocity :Vector2
	
func _ready():
	pass
func _physics_process(delta):
	velocity = parent.velocity
	move_and_collide(velocity)
