class_name Simulation

# N*m^2*kg^-2
const G = 6.6743E-11

# seconds
@export var timestep: int
var totalTime: int

# All celestial bodies
var celestial_bodies: Array

func _init():
	timestep = 1
	totalTime = 0
	celestial_bodies = Array()

func update(timestep):
	for body in celestial_bodies:
		pass
