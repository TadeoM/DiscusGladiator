extends Node

class_name Layout

var orientation : Orientation
var size : Point
var origin : Point

func _init(orientation_: Orientation, size_: Point, origin_: Point):
	orientation = orientation_
	size = size_
	origin = origin_
