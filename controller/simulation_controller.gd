class_name SimulationController extends Node

var simulation: Simulation 
# timesteps per frame
@export var speed := 30
var renderer = preload("res://rendering/celestial_body_renderer.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	simulation = Simulation.new()
	spawn_celestial_body(Vector3(0, 0, 0), Vector3(0, 0, 0), 1.98842e30, 39570000)
	spawn_celestial_body(Vector3(1.49598e11, 0, 0), Vector3(0, 0, -29780), 5.97219e24, 6371008.4)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for i in range(0, speed):
		simulation.update()

func spawn_celestial_body(pos: Vector3, vel: Vector3, mass: float, radius: float):
	var body = CelestialBody.new(pos, vel, Vector3.ZERO, mass, radius)
	print(body.mass)
	print("making body")
	simulation.celestial_bodies.append(body)
	var render = renderer.instantiate() 
	$"../CelestialBodies".add_child(render)
	render.body = body
