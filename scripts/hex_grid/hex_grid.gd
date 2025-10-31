extends TileMapLayer

class_name HexGrid

enum Shape {PARALLELOGRAM,RECTANGLE, TRIANGLE, HEXAGON }

@export var shape := Shape.TRIANGLE
var grid := Dictionary()
var layout = Layout.new(HexHelper.layout_flat, Point.new(200, 200), Point.new(0,0))
var point : Point
@export var length : int = 5
@export var width : int = 5
@export var size : int = 5

func _ready():
	print(length, width)
	if(shape == Shape.PARALLELOGRAM):
		for q in range(-length,length+1):
			for r in range(-width, width+1):
				var newHex = Hex.new(q, r, -q-r)
				var vecPos := Vector2i(q, r)
				grid.set(vecPos, newHex)
				set_cell(vecPos, 0, Vector2i(3,0))
	elif(shape == Shape.TRIANGLE):
		for q in range(0, size+1):
			for r in range(size - q, size+1):
				var newHex = Hex.new(q, r, -q-r)
				var vecPos := Vector2i(q, r)
				grid.set(vecPos, newHex)
				set_cell(vecPos, 0, Vector2i(3,0))
	elif(shape == Shape.HEXAGON):
		for q in range(-size, size+1):
			var r1 = max(-size, -q - size)
			var r2 = min( size, -q + size)
			for r in range(r1, r2+1):
				var newHex = Hex.new(q, r, -q-r)
				var vecPos := Vector2i(q, r)
				grid.set(vecPos, newHex)
				set_cell(vecPos, 0, Vector2i(3,0))
	# we need pixel to hex function working to properly print
	#point = HexHelper.hex_to_pixel(layout, grid[Vector2i(0,1)])
	#print(grid[Vector2i(5,1)].q,',',  grid[Vector2i(0,1)].r)
