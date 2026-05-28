class_name SpacecraftSimulation

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
# Name of planet
var name: String

# List of previous locations
var previous_locations: Array

# Only used in the calculations for other attributes
# Mm/s^2
var accel_old: Vector3

func _init():
	pass

func init_vars(name: String, pos: Vector3, vel: Vector3, rot_vel: Vector3, mass: float):
	self.name = name
	self.pos = pos
	self.vel = vel
	self.accel = Vector3.ZERO
	self.rot = Vector3.ZERO
	self.rot_vel = rot_vel
	self.mass = mass
	self.previous_locations = Array()

func apply_thrust():
	pass

func duplicate() -> SpacecraftSimulation:
	var new_body = SpacecraftSimulation.new()
	new_body.init_vars(name, pos, vel, rot_vel, mass)
	return new_body
