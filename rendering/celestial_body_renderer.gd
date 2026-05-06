class_name CelestialBodyRenderer extends Node3D

var colour: Color
var following: bool = false
var sim_body: CelestialBodySimulation

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Instantiating CelestialBodyRenderer")
	sim_body = get_parent().sim_body
	scale = Vector3.ONE * (sim_body.radius / Globals.size_scale)
	
	$Mesh.set_surface_override_material(0, load("res://assets/default_body.tres").duplicate())
	#$Mesh.get_surface_override_material(0).albedo_color = colour

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	position = sim_body.pos / Globals.distance_scale
	rotation = sim_body.rot
	if (following):
		$"../../Camera3D".move(sim_body.vel / Globals.size_scale)

func set_following(following: bool):
	self.following = following
