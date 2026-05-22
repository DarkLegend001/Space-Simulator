class_name SimulationController extends Node

var main_simulation: Simulation
var bodies: Array 
var paths: Array
# timesteps per second
@export var speed := 1000
# seconds of physics per timestep
@export var timestep := 60
# number of timesteps for prediction
@export var prediction_length := 30
# size of prediction timesteps 
@export var prediction_timestep := 36000

var elapsed_update_time := 0.0

var celestial_body_scene = preload("res://main/celestial_body.tscn")
var celestial_path_scene = preload("res://rendering/celestial_path_renderer.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_simulation = Simulation.new()
	load_presets()
	for i in bodies.size():
		spawn_celestial_path()

# I have no idea why but this function needs to be multiplied by 2 to work properly, don't touch it
func move_camera(velocity: Vector3, delta: float):
	$"../Camera3D".move(2 * velocity * speed * timestep * delta / Globals.distance_scale)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	elapsed_update_time += delta
	while elapsed_update_time > 1.0 / speed:
		main_simulation.update(timestep)
		elapsed_update_time -= 1.0 / speed
	var curves = get_curves()
	for i in range(0, paths.size()):
		paths[i].generate_mesh(curves[i])

func spawn_celestial_body(title: String, pos: Vector3, vel: Vector3, mass: float, radius: float, luminance:float, color: Color):
	var sim_body = CelestialBodySimulation.new()
	sim_body.init_vars(pos, vel, Vector3.ZERO, mass, radius)
	main_simulation.celestial_bodies.append(sim_body)
	var body = celestial_body_scene.instantiate() 
	main_simulation.celestial_bodies.append(sim_body)
	body.sim_body = sim_body
	body.get_child(0).color = color
	body.get_child(0).luminance = luminance
	$"../CelestialBodies".add_child(body)
	bodies.append(body)

func spawn_celestial_path():
	var path = celestial_path_scene.instantiate()
	$"../CelestialPaths".add_child(path)
	paths.append(path)

func load_presets(): 
	var file = FileAccess.open("res://data/presets.txt", FileAccess.READ)
	var contents = file.get_as_text().trim_suffix("\n").split("\n")
	for line in contents:
		if line[0] == "#":
			continue
		var elements = line.split(",")
		var title = elements[0]
		var pos = Vector3(float(elements[1]), float(elements[2]), float(elements[3]))
		var vel = Vector3(float(elements[4]), float(elements[5]), float(elements[6]))
		var mass = float(elements[7])
		var radius = float(elements[8])
		var luminance = float(elements[9])
		var color = Color.from_rgba8(int(elements[10]), int(elements[11]), int(elements[12]), int(elements[13]))
		
		spawn_celestial_body(title, pos, vel, mass, radius, luminance, color)

# This method relies on the order of bodies being consistent in all arrays
func get_curves() -> Array:
	var paths := Array()
	var prediction_sim = main_simulation.duplicate(true)
	for i in prediction_length:
		prediction_sim.update(prediction_timestep)
		for j in prediction_sim.celestial_bodies.size():
			paths[j].append(prediction_sim.celestial_bodies[j])
	return paths
