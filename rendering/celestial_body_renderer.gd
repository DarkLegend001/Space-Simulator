class_name CelestialBodyRenderer extends Node3D

var body: CelestialBody

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Instantiating 'CelstialBodyRenderer")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	position = body.pos
	rotation = body.rot

func _init():
	pass

func update_pos(pos: Vector3, rot: Vector3):
	self.pos = pos
	self.rot = rot
