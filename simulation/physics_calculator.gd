class_name PhysicsCalculator

# not E-11 because not using SI units
const G = 6.6743E-26

# Verlet Intergration; https://www.algorithm-archive.org/contents/verlet_integration/verlet_integration.html
static func integrate_forces(bodies, timestep):
	for body in bodies: 
		body.pos += body.vel * timestep + 0.5 * body.accel * timestep ** 2
	for body in bodies:
		body.accel_old = body.accel
	for body in bodies:
		body.accel = get_accel(body, bodies)
	for body in bodies:
		body.vel += 0.5 * (body.accel + body.accel_old) * timestep
	for body in bodies:
		body.rot += body.rot_vel * timestep

static func get_accel(body, bodies) -> Vector3:
	var accel = Vector3.ZERO
	for other in bodies:
		if body != other:
			var scalar = (G * other.mass) / (body.pos.distance_to(other.pos) ** 2)
			accel += (other.pos - body.pos).normalized() * scalar
	return accel
