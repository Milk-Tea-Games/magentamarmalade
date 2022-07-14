class_name Manager

extends Node2D


var CORELIB = MagentaLib.new()

onready var TREE = get_tree()
onready var ROOT = TREE.get_root()

# Setup

# FIXME this function needs to be redone to actually work. Maybe be reassigned as a core function
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

func get_sibling(name):
	return get_parent().get_node(name)

func connect_to_sibling(sibling, sig, method):
	connect(sig,get_parent().get_node(sibling),method)
	pass

func send_manpack():
	pass


