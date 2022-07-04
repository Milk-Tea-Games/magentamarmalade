# FIXME redundant file, delet this.

extends Node

var count: int = 0
var frametick: int = 0

# Signals

signal clock_ticked


# GAMESTATE Stuff
func quit_game():
	notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)


# TIME stuff

func clock_tick():
	count += 1
	frametick = 0
	print(count)
	emit_signal('clock_ticked') # clock signal
	pass

func count_tick_check():
	
	if frametick == 60:
		clock_tick()
	else:
		frametick += 1

func get_count():
	return count



func _init():
	pass

func _ready():
	pass

func _process(_delta):
	count_tick_check()


