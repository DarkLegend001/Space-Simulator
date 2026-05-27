class_name SimulationController extends Node

var main_simulation: Simulation
var bodies: Array 
var prediction_paths: Array
var previous_paths: Array

# timesteps per second
@export var speed := 500
# seconds of physics per timestep
@export var timestep := 300

# number of timesteps for each prediction
@export var prediction_length := 150
# seconds of physics per predicted timestep
@export var prediction_timestep := 36000
# predictions per second
@export var prediction_speed := 10
# number of previous positions stored
@export var num_prev_positions := 150
# number of times previous positions are stored per second
@export var store_speed := 1


var elapsed_update_time := 0.0
var elapsed_prediction_time := 1.0 / prediction_speed
var elapsed_store_time := 1.0 / prediction_speed

var celestial_body_scene = preload("res://main/celestial_body.tscn")
var celestial_path_scene = preload("res://rendering/celestial_path_renderer.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_simulation = Simulation.new()
	load_presets()
	for i in bodies.size():
		spawn_prediction_celestial_path()
		spawn_previous_celestial_path()

# I figured out why this function needed to be multiplied by 2 to work properly, but not why it worked at all
func move_camera(velocity: Vector3, delta: float):
	$"../Camera3D".move(velocity * speed * timestep * delta / Globals.distance_scale)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	elapsed_prediction_time += delta
	elapsed_store_time += delta
	if elapsed_store_time > 1.0 / store_speed:
		elapsed_store_time = 0
		for body in main_simulation.celestial_bodies:
			body.previous_locations.insert(0, body.pos)
			body.previous_locations.remove_at(num_prev_positions)
		for i in range(prediction_paths.size()):
			previous_paths[i].generate_mesh(main_simulation.celestial_bodies[i].previous_locations)
	if elapsed_prediction_time > 1.0 / prediction_speed:
		elapsed_prediction_time = 0
		var curves = get_predicted_curves()
		for i in range(curves.size()):
			prediction_paths[i].generate_mesh(curves[i])

func _physics_process(delta: float) -> void:
	elapsed_update_time += delta
	
	while elapsed_update_time > 1.0 / speed:
		main_simulation.update(timestep)
		elapsed_update_time -= 1.0 / speed

func spawn_celestial_body(_title, pos: Vector3, vel: Vector3, mass: float, radius: float, luminance:float, color: Color):
	var sim_body = CelestialBodySimulation.new()
	var body = celestial_body_scene.instantiate()
	main_simulation.celestial_bodies.append(sim_body)
	sim_body.init_vars(pos, vel, Vector3.ZERO, mass, radius)
	sim_body.previous_locations.resize(num_prev_positions)
	sim_body.previous_locations.fill(pos)
	body.sim_body = sim_body
	body.get_child(0).color = color
	body.get_child(0).luminance = luminance
	$"../CelestialBodies".add_child(body)
	bodies.append(body)

func spawn_prediction_celestial_path():
	var path = celestial_path_scene.instantiate()
	$"../CelestialPaths".add_child(path)
	path.color = Color.SKY_BLUE
	prediction_paths.append(path)

func spawn_previous_celestial_path():
	var path = celestial_path_scene.instantiate()
	$"../CelestialPaths".add_child(path)
	path.color = Color.CORNFLOWER_BLUE
	previous_paths.append(path)

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

# returns a 2d array of Vector3s
func get_predicted_curves() -> Array:
	var calc_paths = Array()
	for i in range(bodies.size()):
		calc_paths.append(PackedVector3Array())
	var prediction_sim: Simulation = main_simulation.duplicate()
	for i in range(prediction_length):
		for j in range(bodies.size()):
			calc_paths[j].append(prediction_sim.celestial_bodies[j].pos)
		prediction_sim.update(prediction_timestep)
	return calc_paths
