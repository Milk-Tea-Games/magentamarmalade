extends Object

const InputMap = ["left","right","up","down"]
const InputVectors = [[-1,0],[1,0],[0,-1],[0,1]]
enum VectorEnum {left,right,up,down}
const test = "CoreLib"

# Global singleton reference


# Static Object

# Dynamic Object

const VECTOR_ZERO = Vector2(0,0)
const MAX_SPEED = 600 # 300 default

func group_self_as_dynamic():
	print(test)

# Player
const INTERACT_DISTANCE = 250


# Util

func player_interact():
	print(VectorEnum["left"])

