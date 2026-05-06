class_name CelestialBody

var pos: Vector3
var vel: Vector3
var accel: Vector3
var rot: Vector3
var rot_vel: Vector3
var mass: float
var radius: float
var color: Color

# Only used in the calculations for other attributes
var accel_old: Vector3


func _init(pos: Vector3, vel: Vector3, rot_vel: Vector3, mass: float, radius: float, color: Color):
	self.pos = pos
	self.vel = vel
	self.accel = Vector3.ZERO
	self.rot = Vector3.ZERO
	self.rot_vel = rot_vel
	self.mass = mass
	self.radius = radius
	self.color = color
