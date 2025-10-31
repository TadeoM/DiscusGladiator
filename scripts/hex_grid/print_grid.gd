extends Node2D

@onready var hexGrid : HexGrid = get_parent()

func _draw() -> void:
	if(hexGrid.point != null):
		z_index = 5
		#print(hexGrid.point)
		draw_circle(Vector2(hexGrid.point.x, hexGrid.point.y), 50.0, Color.RED)
