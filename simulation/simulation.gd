class_name Simulation

# seconds
var totalTime: int

# All celestial bodies
var celestial_bodies: Array


func _init():
	totalTime = 0
	celestial_bodies = Array()

# deep duplicates another simulation's celestial bodies into a new simulation
func duplicate() -> Simulation:
	var new_sim = Simulation.new()
	for i in range(celestial_bodies.size()):
		new_sim.celestial_bodies.append(celestial_bodies[i].duplicate())
	return new_sim

func update(timestep: float):
	#print("Updating 'Simulation'")
	PhysicsCalculator.integrate_forces(celestial_bodies, timestep)
