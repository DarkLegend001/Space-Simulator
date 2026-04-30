class_name CelestialBody

var pos: Vector3
var vel: Vector3
var accel: Vector3
var mass: float
var radius: float

func _init(pos: Vector3, vel: Vector3, mass: float, radius: float):
	self.pos = pos
	self.vel = vel
	self.accel = Vector3.ZERO
	self.mass = mass
	self.radius = radius
