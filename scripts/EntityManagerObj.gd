tool

class_name EntityManager, "res://assets/images/icon_EntityManager.png"

extends Node2D

const CORE = preload("res://scripts/CoreLib.gd")


onready var PlayerNode = get_node("Player")

# Custom Methods

func handle_player_interact(result, entity):
	print(result)
	if result:
		result.collider.on_interact(entity)




func _ready():

	# Signals

	PlayerNode.connect("playerInteracted", self, "handle_player_interact")

	pass

func _process(delta):
	#print(get_children().size())
	pass
