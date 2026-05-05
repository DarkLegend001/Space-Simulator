class_name CelestialBodyRenderer extends Node3D

var body: CelestialBody

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Instantiating 'CelstialBodyRenderer")
	scale = Vector3.ONE * (body.radius / Globals.size_scale)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	position = body.pos / Globals.distance_scale
	rotation = body.rot
