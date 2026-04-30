extends Node

var simulation: Simulation 
var timesteps_per_second = 60

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("start")
	simulation = Simulation.new()
	spawnCelestialBody(Vector3.ZERO, Vector3.ZERO, 1, 1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for i in range(0, ceil(timesteps_per_second / delta), 1):
		simulation.update()

func spawnCelestialBody(pos: Vector3, vel: Vector3, mass: float, radius: float):
	var body = CelestialBody.new(pos, vel, Vector3.ZERO, mass, radius)
	simulation.celestial_bodies.append(body)
	var renderer = preload("res://rendering/celestial_body_renderer.tscn").instantiate() 
	$"../CelestialBodies".add_child(renderer)
	renderer.body = body
	print("added new renderer")
