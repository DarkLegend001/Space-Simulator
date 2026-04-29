class_name CelestialBody

var position: Vector3
var velocity: Vector3
var acceleration: Vector3
var mass: float
var radius: float

func _init(position: Vector3, velocity: Vector3, mass: float, radius: float):
	self.position = position
	self.velocity = velocity
	self.acceleration = Vector3.ZERO
	self.mass = mass
	self.radius = radius
