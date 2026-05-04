extends Node2D

var body: CelestialBody

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (body):
		position = Vector2(body.pos.x, -body.pos.z)


func _init() -> void:
	print("Instantiating new 'CelestialBodyRenderer")
