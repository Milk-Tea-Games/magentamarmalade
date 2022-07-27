extends GutTest

var _Main : Node
var _Manager : Node
var TestObjectName : String = "EntityManager"
var TestName : String = "Setup"
var NextTestName : String
#SETUP

# Before Each
func before_each():
	
	gut.p("\n \n \n \n[]----[]----[]----[]----[]----[] TEST BEGIN " + TestObjectName + " << " + TestName + ">> []----[]----[]----[]----[]----[] \n")
	
	# setup : Main
	_Main = MainObj.new()
	_Main.set_name("GAME")

	add_child(_Main)

	if(_Main.get_name() and _Main.get_index()):

		gut.p("()--()--()--() BUILT: " + _Main.get_name())


	# setup : Manager

	_Manager = _Main.get_node(TestObjectName)


	if(_Manager.get_name() and _Manager.get_index()):

		gut.p("()--()--()--() BUILT: " + _Manager.get_name())


	gut.p("[]---------[] Orphans present: " + str(Performance.get_monitor(Performance.OBJECT_ORPHAN_NODE_COUNT)))
	gut.p("\n \n \n \n")



# After Each

func after_each():
	_Main.free()

	gut.p("[]----[]----[]----[]----[]----[] TEST END " + TestObjectName + " << " + TestName + " >>  []----[]----[]----[]----[]----[] \n")
	TestName = NextTestName
	if _Main:
		pass
	else:
		gut.p("()--()--()--() ENVIRONMENT UN-BUILT ()--()--()--()")
	
	gut.p("[]---------[] Orphans present: " + str(Performance.get_monitor(Performance.OBJECT_ORPHAN_NODE_COUNT)))
	gut.p("\n \n \n \n")



############################################### 	T 			###############################################
############################################### 	 E 			###############################################
############################################### 	  S			###############################################
############################################### 	   T 		###############################################
############################################### 	    I		###############################################
############################################### 	     N 		###############################################
############################################### 	      G 	###############################################


# Setup Check

func test_setup_check():
	TestName = "Setup"
	NextTestName = "Transpose Player"

	gut.p("|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_||| PASSING TEST CHECK |||_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|\n")
	
	assert_eq(_Main.get_name(),"GAME","This is a placeholder test. SHOULD PASS.")

	var children = _Main.get_children()
	var size = children.size()


	assert_eq(size,2, "_Main child count test") # MainObj creates 2 children on ready, MapManager and EntityManager


	gut.p("This is a setup test. MainObj exists and has " + str(size) + " children: ") 

	for n in children: # Iteratively print names of children
		gut.p( "Child: " + n.name)
	
	assert_true(typeof(_Main.get_node(TestObjectName)) == TYPE_OBJECT, TestObjectName + " should exist.")

# < transpose_player >

func test_transpose_player():

	TestName = "Transpose Player"
	NextTestName = "Player Interact"
	# Player setup
	var player = load("res://scenes/objects/Player.tscn")
	player = player.instance()
	_Manager.add_child(player)

	# Player must be real
	assert_has_method(player, "connect_to_entitymanager", "Player should have method 'connect_to_entitymanager' ")

	var oldpos = player.get_position()
	var newpos = oldpos + Vector2(64,64)

	_Manager.transpose_player(newpos)

	var evennewerpos = player.get_position()

	assert_ne(newpos, oldpos, "Newpos should not be the same as oldpos.")
	assert_eq(newpos,evennewerpos, "newpos and evennewerpos should be the same")


# < Player Interact>

func test_player_interact():

	TestName = "Transpose Player"
	NextTestName = "Player Interact"
	# Player setup
	var player = load("res://scenes/objects/Player.tscn")
	player = player.instance()
	_Manager.add_child(player)