extends Node

var simulation: Simulation 
var timesteps_per_second = 60
var renderer = preload("res://rendering/celestial_body_renderer.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	simulation = Simulation.new()
	#spawnCelestialBody(Vector3(5.7735, 0, 0), Vector3(0, 0, 3.4), 1e12, 1)
	spawnCelestialBody(Vector3.ZERO, Vector3(0, 0, 1), 1, 1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	simulation.update()

func spawnCelestialBody(pos: Vector3, vel: Vector3, mass: float, radius: float):
	var body = CelestialBody.new(pos, vel, Vector3.ZERO, mass, radius)
	simulation.celestial_bodies.append(body)
	var render = renderer.instantiate() 
	$"../CelestialBodies".add_child(render)
	render.body = body
