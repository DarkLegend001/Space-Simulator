class_name Simulation



# seconds
var timestep: int
var totalTime: int

# All celestial bodies
var celestial_bodies: Array[CelestialBody]
var calculator: PhysicsCalculator


func _init():
	timestep = 1
	totalTime = 0
	celestial_bodies = Array()
	calculator = PhysicsCalculator.new()

func update(timestep):
	for body in celestial_bodies:
		calculator.integrate_forces(body, celestial_bodies, timestep)
		

func spawnCelestialBody(position: Vector3, velocity: Vector3, mass: float, radius: float):
	celestial_bodies.append(CelestialBody.new(position, velocity, mass, radius))
