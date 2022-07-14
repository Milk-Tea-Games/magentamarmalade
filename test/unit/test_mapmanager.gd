extends GutTest

var _Main : Node



# BEFORE EACH
func before_each():
	gut.p("\n \n \n \n[]----[]----[]----[]----[]----[] TEST BEGIN []----[]----[]----[]----[]----[] \n")
	
	_Main = MainObj.new()
	_Main.set_name("GAME")
	add_child(_Main)
	if(_Main.get_name() and _Main.get_index()):
		gut.p("()--()--()--() ENVIRONMENT BUILT ()--()--()--()")
	
	gut.p("[]---------[] Orphans present: " + str(Performance.get_monitor(Performance.OBJECT_ORPHAN_NODE_COUNT)))
	gut.p("\n \n \n \n")



# AFTER EACH

func after_each():
	_Main.free()

	gut.p("[]----[]----[]----[]----[]----[] TEST END []----[]----[]----[]----[]----[] \n")

	if _Main:
		pass
	else:
		gut.p("()--()--()--() ENVIRONMENT UN-BUILT ()--()--()--()")
	
	gut.p("[]---------[] Orphans present: " + str(Performance.get_monitor(Performance.OBJECT_ORPHAN_NODE_COUNT)))
	gut.p("\n \n \n \n")




func test_holder():
	gut.p("|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_||| PASSING TEST CHECK |||_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|\n")
	assert_eq(_Main.get_name(),"GAME","This is a placeholder test. SHOULD PASS.")


func test_setup():
	assert_eq(_Main.get_child_count(),2, "_Main child count test")
