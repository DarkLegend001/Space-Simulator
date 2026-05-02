extends Node2D

var body: CelestialBody

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("'CelestialBodyRenderer' ready")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = Vector2(body.pos.x, -body.pos.z)
	print(position)

func _init() -> void:
	print("Instantiating new 'CelestialBodyRenderer")
