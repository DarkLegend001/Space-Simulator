class_name PhysicsCalculator

# N*m^2*kg^-2
const G = 6.6743E-11

# Verlet Intergration; https://www.algorithm-archive.org/contents/verlet_integration/verlet_integration.html
# I may need to update the positions of every body before I update the accelerations of everything,
# but I will do that later if stuff does not go well
func integrate_forces(body, bodies, timestep):
	print(body.vel)
	print(body.accel)
	var vel_half = body.vel + 0.5 * body.accel * timestep
	#print(body.pos)
	body.pos += vel_half * timestep
	#print(body.pos)
	body.accel = calculate_force(body, bodies) / body.mass
	body.vel = vel_half + 0.5 * body.accel * timestep

func calculate_force(body, bodies) -> Vector3:
	var force = Vector3.ZERO
	for other in bodies:
		if body != other:
			var scalar = (G * body.mass * other.mass) / (body.pos.distance_to(other.pos) ** 2)
			force += (other.pos - body.pos).normalized() * scalar
	return force
