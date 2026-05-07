class_name SimulationController extends Node

var simulation: Simulation
var bodies: Array 
# timesteps per frame
@export var speed := 50
var celestial_body_scene = preload("res://main/celestial_body.tscn")
var celestial_body_renderer = preload("res://rendering/celestial_body_renderer.tscn")
var sun_renderer = preload("res://rendering/sun_renderer.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	simulation = Simulation.new()
	#spawn_sun("Sun", Vector3.ZERO, Vector3.ZERO, 1.98842e30, 39570000, 100, Color(1.0, 1.0, 0.392, 1.0))
	load_presets()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for i in range(0, speed):
		simulation.update()

func spawn_celestial_body(title: String, pos: Vector3, vel: Vector3, mass: float, radius: float, color: Color):
	var sim_body = CelestialBodySimulation.new(pos, vel, Vector3.ZERO, mass, radius)
	simulation.celestial_bodies.append(sim_body)
	var body = celestial_body_scene.instantiate() 
	body.sim_body = sim_body
	body.get_child(0).color = color
	$"../CelestialBodies".add_child(body)
	bodies.append(body)
	

func spawn_sun(title: String, pos: Vector3, vel: Vector3, mass: float, radius: float, energy: float, color: Color):
	var sim_body = SunSimulation.new(pos, vel, Vector3.ZERO, mass, radius, energy)
	simulation.celestial_bodies.append(sim_body)
	var body = celestial_body_scene.instantiate() 
	body.sim_body = sim_body
	$"../CelestialBodies".add_child(body)
	bodies.append(body)

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
	
