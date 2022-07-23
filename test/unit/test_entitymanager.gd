extends GutTest

var _Main : Node
var _Manager : Node
var TestObjectName : String = "EntityManager"
var TestName : String
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


