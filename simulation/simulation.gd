class_name Simulation

# seconds
@export var timestep: float
@export var total_time: int

# All celestial bodies
var celestial_bodies: Array
var calculator: PhysicsCalculator


func _init():
	timestep = 100
	total_time = 0
	celestial_bodies = Array()
	calculator = PhysicsCalculator.new()

func update():
	#print("Updating 'Simulation'")
	calculator.integrate_forces(celestial_bodies, timestep)
	total_time += timestep
