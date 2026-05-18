class_name CelestialPathRenderer extends Node3D

var color: Color

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func set_curve(curve: Curve3D):
	$CurvePolygon/Path.curve = curve

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
