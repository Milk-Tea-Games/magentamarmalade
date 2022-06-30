class_name Manager

extends Node2D

onready var TREE = get_tree()
onready var ROOT = TREE.get_root()
var Parent = null

# Setup

func connect_to_many(signal_list):
	for n in signal_list:
		var node = n.node or self
		var sig = n.sig
		var met = n.met
		if sig and node:
			connect(sig, node, met)
	pass

func connect_to_child(node):
	node.connect_to_parent()
	pass

# Behaviour of dependents

func call_child_method(): # For node-node interactions
	pass


# Inter-Manager Behaviour

func connect_to_sibling(sibling, sig, method):
	connect(sig,get_parent().get_node(sibling),method)
	pass

func send_manpack():
	pass

func _init():
	Parent = get_parent()
