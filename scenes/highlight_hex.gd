extends Node2D


@export var size := 1
@export var color := Color(1.0, 1.0, 0.0, 0.5)

func _draw():
	var one := Vector2(-(size/4), sqrt(3) * (size / 4))
	var two := Vector2((size/4), sqrt(3) * (size / 4))
	
	var three := Vector2((size/2), sqrt(3) * (size / 4))
	var four := Vector2((size/4), sqrt(3) * (size / 4))
	
	var five := Vector2(-(size/4), sqrt(3) * (size / 4))
	var six := Vector2((size/4), sqrt(3) * (size / 4))
	#draw_polygon()
