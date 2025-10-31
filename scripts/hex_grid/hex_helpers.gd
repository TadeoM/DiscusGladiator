extends Node

class_name HexHelper

static var directions := [Hex.new(1, 0, -1), Hex.new(1, -1, 0), Hex.new(0, -1, 1), 
				   Hex.new(-1, 0, 01), Hex.new(-1, 1, 0), Hex.new(0, 1, -1)]

# point refers to the hex being oriented such that left and right is flat and top and bottom are points
static var layout_point := Orientation.new(sqrt(3.0), sqrt(3.0) / 2.0, 0.0, 3.0 / 2.0,
					sqrt(3.0) / 3.0, -1.0 / 3.0, 0.0, 2.0 / 3.0,
					0.5)

static var layout_flat := Orientation.new(3.0 / 2.0, 0.0, sqrt(3.0) / 2.0, sqrt(3.0),
				2.0 / 3.0, 0.0, -1.0 / 3.0, sqrt(3.0) / 3.0,
				0.0)

static func equals(a: Hex, b: Hex) -> bool:
	return a.q == b.q && a.r == b.r && a.s == b.s

static func add(a: Hex, b: Hex) -> Hex:
	return Hex.new(a.q + b.q, a.r + b.r, a.s + b.s)
	
static func subtract(a: Hex, b: Hex) -> Hex:
	return Hex.new(a.q - b.q, a.r - b.r, a.s - b.s)

static func multiply(a: Hex, b: Hex) -> Hex:
	return Hex.new(a.q * b.q, a.r * b.r, a.s * b.s)

static func length(a: Hex) -> int:
	return int((absi(a.q) + absi(a.r) + absi(a.s)) / 2)

static func distance_between(a: Hex, b: Hex):
	return length(subtract(a, b))

static func direction( direction: int) -> Hex:
	assert(0 <= direction && direction < 5)
	return directions[direction]

static func neighbor(a: Hex, direction: int) -> Hex:
	return add(a, direction(direction))

static func hex_to_pixel(layout: Layout, h: Hex) -> Point:
	var M := layout.orientation
	var x := (M.f0 * h.q + M.f1 * h.r) * layout.size.x
	var y := (M.f2 * h.q + M.f3 * h.r) * layout.size.y
	return Point.new(x + layout.origin.x, y + layout.origin.y)

static func pixel_to_hex_fractional(layout: Layout, p: Point):
	var m : Orientation = layout.orientation
	var pt : Point = Point.new((p.x - layout.origin.x) / layout.size.x,
						(p.y - layout.origin.y) / layout.size.y)
	var q : float  = m.b0 * pt.x + m.b1 * pt.y 
	var r : float  = m.b2 * pt.x + m.b3 * pt.y
	return FractionalHex.new(q, r, -q-r)

static func hex_corner_offset(layout: Layout , corner: int) -> Point:
	var size : Point = layout.size
	var angle : float = 2.0 * PI * (layout.orientation.start_angle + corner) / 6
	return Point.new(size.x * cos(angle), size.y * sin(angle))

static func polygon_corners(layout: Layout, h: Hex) -> Array:
	var corners := Array([], TYPE_OBJECT, "Point", null)
	var center : Point = hex_to_pixel(layout, h)
	for i in range(6):
		var offset : Point = hex_corner_offset(layout, i)
		corners.push_back(Point.new(center.x + offset.x, center.y + offset.y))
	return corners

static func hex_round(hex: FractionalHex) -> Hex:
	var q : int  = roundi(hex.q)
	var r : int  = roundi(hex.r)
	var s : int  = roundi(hex.s)
	
	var q_diff : float = abs(q - hex.q)
	var r_diff : float = abs(r - hex.r)
	var s_diff : float = abs(s - hex.s)
	
	if (q_diff > r_diff and q_diff > s_diff):
		q = -r-s
	elif (r_diff > s_diff):
		r = -q-s
	else: 
		s = -q-r
	return Hex.new(q, r, s)

static func lerp(a: float, b: float, t: float) -> float:
	return a * (1-t) + b*t

static func hex_lerp(a: Hex, b: Hex, t: float) -> FractionalHex:
	return FractionalHex.new(lerp(a.q, b.q, t),
							  lerp(a.r, b.r, t),
							  lerp(a.s, b.s, t))

static func hex_linedraw(a: Hex, b: Hex) -> Array:
	var n: int = distance_between(a, b)
	var results := Array([], TYPE_OBJECT, "Node", null)
	var step : float = 1.0 / max(n, 1)
	for i in range(n):
		results.push_back(hex_round(hex_lerp(a, b, step * i)))
	return results


static func hash_int(i: int, hasher: HashingContext) -> PackedByteArray:
	hasher.start(HashingContext.HASH_SHA256)
	hasher.update(str(i).to_utf8_buffer())
	return hasher.finish()

static func hash_hex(hex: Hex):
	# Here we start with a new hash.
	var hasher = HashingContext.new()
	var _hash_constant = 0x9e3779b9;
	
	var q_hash := hash_int(hex.q, hasher)
	var r_hash := hash_int(hex.r, hasher)
	var hashedHex := q_hash + r_hash
	return hashedHex
