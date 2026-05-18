class_name SimulationController extends Node

var main_simulation: Simulation
var bodies: Array 
var paths: Array
# timesteps per frame
@export var speed := 50
# number of timesteps for prediction
@export var prediction_length := 30
# size of prediction timesteps 
@export var prediction_timestep_size := 3600
var celestial_body_scene = preload("res://main/celestial_body.tscn")
var celestial_path_scene = preload("res://rendering/celestial_path_renderer.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_simulation = Simulation.new()
	load_presets()
	for i in bodies.size():
		spawn_celestial_path()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for i in range(0, speed):
		main_simulation.update()
	var curves = get_curves()
	for i in paths.size():
		paths[i].set_curve(curves[i])

func spawn_celestial_body(title: String, pos: Vector3, vel: Vector3, mass: float, radius: float, color: Color):
	var sim_body = CelestialBodySimulation.new(pos, vel, Vector3.ZERO, mass, radius)
	main_simulation.celestial_bodies.append(sim_body)
	var body = celestial_body_scene.instantiate() 
	body.sim_body = sim_body
	body.get_child(0).color = color
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
		var color = Color.from_rgba8(int(elements[9]), int(elements[10]), int(elements[11]), int(elements[12]))
		
		spawn_celestial_body(title, pos, vel, mass, radius, color)

# This method relies on the order of bodies being consistent in all arrays
func get_curves() -> Array:
	var curves := Array()
	var prediction_sim = main_simulation
	prediction_sim.timestep = prediction_timestep_size
	for body in bodies:
		curves.append(Curve3D.new())
	for i in prediction_length:
		prediction_sim.update()
		for j in prediction_sim.celestial_bodies.size():
			curves[j].add_point(prediction_sim.celestial_bodies[j].pos)
	return curves
