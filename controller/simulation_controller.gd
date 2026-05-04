class_name SimulationController extends Node

var simulation: Simulation 
# timesteps per frame
@export var speed := 30
var renderer = preload("res://rendering/celestial_body_renderer.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	simulation = Simulation.new()
	load_presets()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for i in range(0, speed):
		simulation.update()

func spawn_celestial_body(title: String, pos: Vector3, vel: Vector3, mass: float, radius: float, colour: Color):
	var body = CelestialBody.new(pos, vel, Vector3.ZERO, mass, radius)
	simulation.celestial_bodies.append(body)
	var render = renderer.instantiate() 
	$"../CelestialBodies".add_child(render)
	render.body = body
	render.colour = colour
	render.title = title

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
		var colour = Color.from_rgba8(int(elements[9]), int(elements[10]), int(elements[11]), int(elements[12]))
		
		spawn_celestial_body(title, pos, vel, mass, radius, colour)
	
