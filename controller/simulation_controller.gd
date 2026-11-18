class_name SimulationController extends Node

var main_simulation: Simulation
var prediction_paths: Array
var previous_paths: Array




var elapsed_update_time = 1.0 / Globals.speed
var elapsed_prediction_time = 1.0 / Globals.prediction_speed
var elapsed_store_time = 1.0 / Globals.store_speed
var elapsed_render_store_time = 1.0 / Globals.render_store_speed

var celestial_body_scene = preload("res://main/celestial_body.tscn")
var celestial_path_scene = preload("res://rendering/celestial_path_renderer.tscn")

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	main_simulation = Simulation.new()
	InitialPlanets.reset()
	load_presets()
	for i in main_simulation.celestial_bodies.size():
		spawn_prediction_celestial_path()
		spawn_previous_celestial_path()

# I figured out why this function needed to be multiplied by 2 to work properly, but not why it worked at all
func move_camera(velocity: Vector3, delta: float):
	$"../Camera3D".move(velocity * Globals.speed * Globals.timestep * delta / Globals.distance_scale)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	elapsed_prediction_time += delta
	elapsed_store_time += delta
	elapsed_render_store_time += delta
	
	var follow_body = null
	for body in $"../CelestialBodies".get_children():
		if body.get_child(0).following == true:
			follow_body = body.sim_body
			break
	
	if elapsed_store_time > 1.0 / Globals.store_speed:
		elapsed_store_time = 0
		for body in main_simulation.celestial_bodies:
			body.previous_locations.insert_pop(body.pos)
	
	if elapsed_render_store_time > 1.0 / Globals.render_store_speed:
		elapsed_render_store_time = 0
		if follow_body == null:
			for i in range(prediction_paths.size()):
				previous_paths[i].generate_mesh(main_simulation.celestial_bodies[i].previous_locations.get_data())
		else:
			for i in range(prediction_paths.size()):
				var new_path = main_simulation.celestial_bodies[i].previous_locations.duplicate()
				for j in range(new_path.size()):
					new_path.set_value(j, new_path.get_value(j) - (follow_body.previous_locations.get_value(j) - follow_body.pos))
				previous_paths[i].generate_mesh(new_path.get_data())
	
	if elapsed_prediction_time > 1.0 / Globals.prediction_speed:
		elapsed_prediction_time = 0
		var curves: Array
		if follow_body == null:
			curves = get_predicted_curves()
		else:
			curves = get_relative_predicted_curves(follow_body)
		for i in range(curves.size()):
			prediction_paths[i].generate_mesh(curves[i])

func _physics_process(delta: float) -> void:
	elapsed_update_time += delta
	
	while elapsed_update_time > 1.0 / Globals.speed:
		main_simulation.update(Globals.timestep)
		elapsed_update_time -= 1.0 / Globals.speed

func spawn_celestial_body(name: String, pos: Vector3, vel: Vector3, mass: float, radius: float, luminance:float, color: Color):
	var sim_body = CelestialBodySimulation.new()
	var body = celestial_body_scene.instantiate()
	main_simulation.celestial_bodies.append(sim_body)
	sim_body.init_vars(name, pos, vel, Vector3.ZERO, mass, radius)
	sim_body.previous_locations.resize(Globals.num_prev_positions)
	sim_body.previous_locations.fill(pos)
	body.sim_body = sim_body
	body.get_child(0).color = color
	body.get_child(0).luminance = luminance
	$"../CelestialBodies".add_child(body)

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
	for planet in InitialPlanets.planets:
		spawn_celestial_body(planet.name, planet.pos, planet.vel, planet.mass, planet.radius, planet.luminance, planet.color)

# returns a 2d array of Vector3s
func get_predicted_curves() -> Array:
	var calc_paths = Array()
	var prediction_sim: Simulation = main_simulation.duplicate()
	calc_paths.resize(main_simulation.celestial_bodies.size())
	for i in range(main_simulation.celestial_bodies.size()):
		calc_paths[i] = PackedVector3Array()
	for arr in calc_paths:
		arr.resize(Globals.prediction_length)
	for i in range(Globals.prediction_length):
		for j in range(main_simulation.celestial_bodies.size()):
			calc_paths[j][i] = prediction_sim.celestial_bodies[j].pos
		prediction_sim.update(Globals.prediction_timestep)
	return calc_paths

func get_relative_predicted_curves(body: CelestialBodySimulation) -> Array:
	var calc_paths = Array()
	var prediction_sim: Simulation = main_simulation.duplicate()
	var relative_body: CelestialBodySimulation
	var initial_relative_body_pos
	calc_paths.resize(main_simulation.celestial_bodies.size())
	for i in range(main_simulation.celestial_bodies.size()):
		calc_paths[i] = PackedVector3Array()
	for arr in calc_paths:
		arr.resize(Globals.prediction_length)
	for prediction_body in prediction_sim.celestial_bodies:
		if prediction_body.name == body.name:
			relative_body = prediction_body
			break
	initial_relative_body_pos = relative_body.pos
	for i in range(Globals.prediction_length):
		for j in range(main_simulation.celestial_bodies.size()):
			calc_paths[j][i] = prediction_sim.celestial_bodies[j].pos - (relative_body.pos - initial_relative_body_pos)
		prediction_sim.update(Globals.prediction_timestep)
	return calc_paths
