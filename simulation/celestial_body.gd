class_name CelestialBody

var pos: Vector3
<<<<<<< HEAD
var vel: Vector3
=======
var rot: Vector3
var lin_vel: Vector3
var rot_vel: Vector3
>>>>>>> main
var accel: Vector3
var mass: float
var radius: float

<<<<<<< HEAD
func _init(pos: Vector3, vel: Vector3, mass: float, radius: float):
	self.pos = pos
	self.vel = vel
=======
func _init(pos: Vector3, lin_vel: Vector3, rot_vel: Vector3, mass: float, radius: float):
	self.pos = pos
	self.rot = Vector3.ZERO
	self.lin_vel = lin_vel
	self.rot_vel = rot_vel
>>>>>>> main
	self.accel = Vector3.ZERO
	self.mass = mass
	self.radius = radius
