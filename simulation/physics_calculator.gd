class_name PhysicsCalculator

# not E-11 because not using SI units
const G = 6.6743E-11

# Verlet Intergration; https://www.algorithm-archive.org/contents/verlet_integration/verlet_integration.html
static func integrate_forces_body(bodies, timestep):
	for body in bodies: 
		body.pos += body.vel * timestep + 0.5 * body.accel * timestep ** 2
	for body in bodies:
		body.accel_old = body.accel
	for body in bodies:
		body.accel = get_accel_body(body, bodies)
	for body in bodies:
		body.vel += 0.5 * (body.accel + body.accel_old) * timestep
	for body in bodies:
		body.rot += body.rot_vel * timestep

static func get_accel_body(body, bodies) -> Vector3:
	var accel = Vector3.ZERO
	for other in bodies:
		if body != other:
			var scalar = (G * other.mass) / (body.pos.distance_to(other.pos) ** 2)
			accel += (other.pos - body.pos).normalized() * scalar
	return accel

# position and velocity are of b1 relative to b2
static func get_elements(r, v, m1, m2) -> Dictionary:
	var h = r.cross(v)
	var n = Vector3.BACK.cross(h)
	var mu = G * (m1 + m2)

	var evec = ((v.length()**2 - mu / r.length()) * r - r.dot(v) * v) / mu
	var e = evec.length()

	var energy = v.length()**2 / 2 - mu / r.length()
	
	var a
	var p
	
	if !(e.is_equal_approx(1)):
		a = -mu / (2 * energy)
		p = a * (1 - e**2)
	else:
		p = h.length()**2 / mu
		a = INF
		
	var i = acos(h.z / h.length())
	
	var omega = acos(n.x / v.length())
	
	if n.y < 0:
		omega = 360 - omega
		
	var argp = acos(n.dot(evec) / (n.length() * e))
	
	if e.z < 0:
		argp = 360 - argp
		
	var nu = acos(evec.dot(r) / ( e * r.length()))
	
	if r.dot(v) < 0:
		nu = 360 - nu
	
	if r.dot(v) < 0:
		nu = 360 - nu
		
	return {"a": a, "e": e, "i": i, "omega": omega, "argp": argp, "nu": nu}
