extends Node2D

var body: CelestialBody
var colour: Color

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (body):
		position = Vector2(body.pos.x / Globals.distance_scale, -body.pos.z / Globals.distance_scale)
		queue_redraw()


func _init() -> void:
	print("Instantiating new 'CelestialBodyRenderer'")

func _draw():
	draw_circle(Vector2.ZERO, body.radius / Globals.size_scale, colour)
