class_name CelestialBodyRenderer extends Node3D

var body: CelestialBody

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("ready") # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = body.pos
	rotation = body.rot

func _init():
	print("init")
