extends Timer
class_name TimerSP, "res://assets/images/timer.png"

func new_timeout(a):
	a = a or "empty"
	print(str("Hello there dear ", a))
	start(1)
