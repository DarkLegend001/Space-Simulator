class_name Simulation
extends Resource
# seconds
var totalTime: int

# All celestial bodies
var celestial_bodies: Array
var calculator: PhysicsCalculator


func _init():
	totalTime = 0
	celestial_bodies = Array()
	calculator = PhysicsCalculator.new()

func update(timestep: float):
	#print("Updating 'Simulation'")
	calculator.integrate_forces(celestial_bodies, timestep)
