class_name PhysicsCalculator

# N*m^2*kg^-2
const G = 6.6743E-11# update rotation

# Verlet Intergration; https://www.algorithm-archive.org/contents/verlet_integration/verlet_integration.html
func integrate_forces(bodies, timestep):
	for body in bodies: 
		body.pos += body.vel * timestep + 0.5 * body.accel * timestep ** 2
	for body in bodies:
		body.accel_old = body.accel
	for body in bodies:
		body.accel = calculate_force(body, bodies) / body.mass
	for body in bodies:
		body.vel += 0.5 * (body.accel + body.accel_old) * timestep
	for body in bodies:
		body.rot += body.rot_vel * timestep

func calculate_force(body, bodies) -> Vector3:
	var force = Vector3.ZERO
	for other in bodies:
		if body != other:
			var scalar = (G * body.mass * other.mass) / (body.pos.distance_to(other.pos) ** 2)
			force += (other.pos - body.pos).normalized() * scalar
	return force
