class_name CelestialBodySimulation

# Mm
var pos: Vector3
# Mm/s
var vel: Vector3
# Mm/s^2
var accel: Vector3
# rad
var rot: Vector3
# rad/s
var rot_vel: Vector3
# Mg (tonne)
var mass: float
# Mm
var radius: float

# Only used in the calculations for other attributes
# Mm/s^2
var accel_old: Vector3

func _init():
	pass

func init_vars(pos: Vector3, vel: Vector3, rot_vel: Vector3, mass: float, radius: float):
	self.pos = pos
	self.vel = vel
	self.accel = Vector3.ZERO
	self.rot = Vector3.ZERO
	self.rot_vel = rot_vel
	self.mass = mass
	self.radius = radius

func duplicate() -> CelestialBodySimulation:
	var new_body = CelestialBodySimulation.new()
	new_body.init_vars(pos, vel, rot_vel, mass, radius)
	#print(new_body.pos)
	return new_body
