class_name CelestialBodyRenderer extends Node3D

var body: CelestialBody
var following: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Instantiating CelestialBodyRenderer")
	scale = Vector3.ONE * (body.radius / Globals.size_scale)
	set_material()

func set_material():
	$Mesh.material_overlay = load("res://assets/default_body.tres").duplicate()
	$Mesh.material_overlay.albedo_color = body.color

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	position = body.pos / Globals.distance_scale
	rotation = body.rot
	if (following):
		$"../../Camera3D".move(body.vel / Globals.size_scale)

func set_following(following: bool):
	self.following = following
