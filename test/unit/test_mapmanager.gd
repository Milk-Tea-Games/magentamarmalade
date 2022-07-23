extends GutTest

var _Main : Node
var _Manager : Node
var TestObjectName : String = "MapManager"
var TestName : String
var NextTestName : String
#SETUP

# Before Each
func before_each():
	
	gut.p("\n \n \n \n[]----[]----[]----[]----[]----[] TEST BEGIN MAPMANAGER: << " + TestName + ">> []----[]----[]----[]----[]----[] \n")
	
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

	gut.p("[]----[]----[]----[]----[]----[] TEST END MAPMANAGER: << " + TestName + " >>  []----[]----[]----[]----[]----[] \n")
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



# Ready Check

func test_setup_check():
	TestName = "Setup"
	NextTestName = "Add Map"

	gut.p("|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_||| PASSING TEST CHECK |||_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|\n")
	assert_eq(_Main.get_name(),"GAME","This is a placeholder test. SHOULD PASS.") # MainObj currently only runs the GAME sector of the game.
	#TODO organize layers of game window and make Main the container node for everything


	var children = _Main.get_children()
	var size = children.size()


	assert_eq(size,2, "_Main child count test") # MainObj creates 2 children on ready, MapManager and EntityManager


	gut.p("This is a setup test. MainObj exists and has " + str(size) + " children: ") 

	for n in children: # Iteratively print names of children
		gut.p( "Child: " + n.name)
	
	assert_true(typeof(_Main.get_node("MapManager")) == TYPE_OBJECT, "MapManager should exist.")





# TESTING

# < add_map() >

func test_add_map_as_string():
	TestName = "Add Map"
	NextTestName = "Reparent Entities"

	var mapname = "ASP_spire"

	_Manager.add_map(mapname)

	assert_eq(mapname, _Manager.get_current_mapname(), "Current map name variable change check.") # test if current mapname changes with map add

	assert_true(_Manager.get_current_map().get_name() == mapname , "Map child name check.") # test if mapmanager has a child node with expected name


# < reparent_entities() >

func test_reparent_entities():
	TestName = "Reparent Entities"
	NextTestName = "Get Map By Name"

	gut.p(str(_Main.get_node("EntityManager").get_children()))
	var map = _Manager.get_current_map()

# Test multiple entities reparenting that are not persistent
	for n in 10:
		var newentity = load("res://scenes/objects/MapWarper.tscn")
		newentity = newentity.instance()
		#newentity.set_name("Decoration" + str(n))

		map.add_child(newentity)
	

	var newplayer = Player.new()

	map.add_child(newplayer)


	var mapchildren = map.get_children()
	var map_child_count = mapchildren.size()
	
	for n in mapchildren: # Clearing away non-entity nodes to prevent child count issues downstream
		if n.is_in_group("entity"):
			pass
		else:
			n.free()


	var _EManager = _Main.get_node("EntityManager")

	if _EManager:

		var emanagerchildren = _EManager.get_children()
		var emanager_child_count = emanagerchildren.size()
		
		assert_ne(map_child_count,emanager_child_count, "Map - EntityManager child cound mismatch check.")

		assert_true(emanager_child_count == 0, "EntityManager should have a child count of 0.")

		assert_true(map_child_count > 0, "Map should have a child count above 0.")

		_Manager.reparent_entities(map) # The function being tested

		var old_map_child_count = map_child_count # Retain old value for comparison

		map_child_count = map.get_child_count()
		emanager_child_count = _EManager.get_child_count()

		assert_true(newplayer.is_in_group("persistent"), "Player should be persistent.")

		assert_true(map_child_count == 0, "Map should have a child count of 0." + " Got " + str(map_child_count) + " instead.")

		assert_true(emanager_child_count == old_map_child_count, "EntityManager new child count should equal old Map child count." + " Got " + str(emanager_child_count) + " and " + str(old_map_child_count))

# < get_map_by_name() >

func test_get_map_by_name():

	TestName = "Get Map By Name"
	NextTestName = "Reparent Entities"

	var mapname = "ASP_corridor_1"

	_Manager.add_map(mapname)

	var map = _Manager.get_map_by_name(mapname)

	assert_true(typeof(map) == TYPE_OBJECT, "Returned Map type should be object.")

	assert_true(_Manager.get_current_mapname() == map.get_name(), "Map object name should be identical to name input.")


	
