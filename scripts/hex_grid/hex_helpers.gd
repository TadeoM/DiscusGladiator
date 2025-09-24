extends Node
var directions := [Hex.new(1, 0, -1), Hex.new(1, -1, 0), Hex.new(0, -1, 1), 
				   Hex.new(-1, 0, 01), Hex.new(-1, 1, 0), Hex.new(0, 1, -1)]

# point refers to the hex being oriented such that left and right is flat and top and bottom are points
var layout_point := Orientation.new(sqrt(3.0), sqrt(3.0) / 2.0, 0.0, 3.0 / 2.0,
					sqrt(3.0) / 3.0, -1.0 / 3.0, 0.0, 2.0 / 3.0,
					0.5)

var layout_flat := Orientation.new(3.0 / 2.0, 0.0, sqrt(3.0) / 2.0, sqrt(3.0),
				2.0 / 3.0, 0.0, -1.0 / 3.0, sqrt(3.0) / 3.0,
				0.0)

func equals(a: Hex, b: Hex):
	return a.q == b.q && a.r == b.r && a.s == b.s

func add(a: Hex, b: Hex):
	return Hex.new(a.q + b.q, a.r + b.r, a.s + b.s)
	
func subtract(a: Hex, b: Hex):
	return Hex.new(a.q - b.q, a.r - b.r, a.s - b.s)

func multiply(a: Hex, b: Hex):
	return Hex.new(a.q * b.q, a.r * b.r, a.s * b.s)

func length(a: Hex):
	return int((absi(a.q) + absi(a.r) + absi(a.s)) / 2)

func distanceTo(a: Hex, b: Hex):
	return length(subtract(a, b))

func direction( direction: int):
	assert(0 <= direction && direction < 5)
	return directions[direction]

func neighbor(a: Hex, direction: int):
	return add(a, direction(direction))

func hex_to_pixel(layout: Layout, h: Hex):
	var M := layout.orientation
	var x := (M.f0 * h.q + M.f1 * h.r) * layout.size.x
	var y := (M.f2 * h.q + M.f3 * h.r) * layout.size.y
	return Point.new(x + layout.origin.x, y + layout.origin.y)
