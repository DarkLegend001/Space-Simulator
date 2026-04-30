class_name Simulation



# seconds
var timestep: float
var totalTime: int

# All celestial bodies
var celestial_bodies: Array
var calculator: PhysicsCalculator


func _init():
	timestep = 0.005
	totalTime = 0
	celestial_bodies = Array()
	calculator = PhysicsCalculator.new()

func update():
	for body in celestial_bodies:
		calculator.integrate_forces(body, celestial_bodies, timestep)
