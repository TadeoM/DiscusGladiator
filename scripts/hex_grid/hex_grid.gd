extends TileMapLayer

class_name HexGrid

enum Shape {RECTANGLE, TRIANGLE, HEXAGON }

@export var shape := Shape.TRIANGLE
var grid := Dictionary()
var layout = Layout.new(HexHelper.layout_flat, Point.new(200, 200), Point.new(0,0))
var point : Point
@export var length : int = 5
@export var width : int = 5
@export var size : int = 5

func _ready():
	print(length, width)
	if(shape == Shape.RECTANGLE):
		for q in range(-length,length+1):
			for r in range(-width, width+1):
				var newHex = Hex.new(q, r, -q-r)
				var vecPos := Vector2i(q, r)
				grid.set(vecPos, newHex)
				set_cell(vecPos, 0, Vector2i(3,0))
	elif(shape == Shape.TRIANGLE):
		for q in range(0, size+1):
			for r in range(0, (size - q) + 1):
				var newHex = Hex.new(q, r, -q-r)
				var vecPos := Vector2i(q, r)
				grid.set(vecPos, newHex)
				set_cell(vecPos, 0, Vector2i(3,0))
	# we need pixel to hex function working to properly print
	#point = HexHelper.hex_to_pixel(layout, grid[Vector2i(0,1)])
	#print(grid[Vector2i(5,1)].q,',',  grid[Vector2i(0,1)].r)
