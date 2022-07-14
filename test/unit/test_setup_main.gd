extends GutTest

var _Main : Node

func before_each():
	_Main = MainObj.new()
	_Main.set_name("GAME")
	add_child(_Main)
	#gut.p(get_children())
	#gut.p("Hello bowel")

func test_holder():
	assert_eq(_Main.get_name(),"GAME","This is a placeholder test. SHOULD PASS.")


func after_each():
	_Main.free()
	pass
	