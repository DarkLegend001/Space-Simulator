class_name CelestialBodyRenderer extends Node3D

@export var color: Color
@export var following: bool = false
@export var luminance: float

var sim_body: CelestialBodySimulation

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Instantiating CelestialBodyRenderer")
	sim_body = get_parent().sim_body
	scale = Vector3.ONE * (sim_body.radius / Globals.size_scale)
	
	scale = Vector3.ONE * (sim_body.radius / Globals.size_scale)
	set_material()
	set_light()

func set_material():
	$Mesh.material_overlay = load("res://assets/default_body.tres").duplicate()
	$Mesh.material_overlay.albedo_color = color

func set_light():
	if $Light != null:
		if luminance == 0:
			$Light.free()
		else:
			$Light.light_energy = luminance
			$Light.light_size = sim_body.radius / Globals.size_scale
			$Light.omni_range = 2e5 / Globals.distance_scale
			$Mesh.cast_shadow = false
			$Mesh.material_overlay.shading_mode = 0
			print("making light")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = sim_body.pos / Globals.distance_scale
	rotation = sim_body.rot
	if (following):
		$"../../../SimulationController".move_camera(sim_body.vel, delta)
