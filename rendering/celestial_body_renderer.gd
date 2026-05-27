class_name CelestialBodyRenderer extends Node3D

@export var color: Color
@export var following: bool = false
@export var luminance: float

var sim_body: CelestialBodySimulation

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Instantiating CelestialBodyRenderer")
	sim_body = get_parent().sim_body
	set_light()

func set_light():
	if $Light != null:
		if luminance == 0:
			$Light.free()
		else:
			$Light.light_energy = luminance
			$Light.light_size = sim_body.radius / Globals.size_scale
			$Light.omni_range = 1e6 / Globals.distance_scale
			$Mesh.cast_shadow = false
			$Mesh.mesh.material.shading_mode = 0
			print("making light")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = sim_body.pos / Globals.distance_scale
	rotation = sim_body.rot
	$Mesh.mesh.material.albedo_color = color
	$Mesh.scale = Vector3.ONE * ((1 - Globals.planet_scaling) * (sim_body.radius / Globals.size_scale) + (Globals.planet_scaling) * (200 * sqrt(sim_body.radius) * position.distance_to($"../../../Camera3D".position) / (Globals.size_scale)))
	if (following):
		$"../../../SimulationController".move_camera(sim_body.vel, delta)
