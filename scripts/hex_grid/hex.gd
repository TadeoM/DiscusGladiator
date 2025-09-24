extends Node

class_name Hex

var q : int
var r : int
var s : int

func _init(qPos: int, rPos: int, sPos: int):
	assert(qPos + rPos + sPos == 0, "Hex Grid position does not add up to 0.")
