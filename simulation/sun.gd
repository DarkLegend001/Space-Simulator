class_name Sun extends CelestialBody

var energy: float

func _init(pos: Vector3, vel: Vector3, rot_vel: Vector3, mass: float, radius: float, energy: float, color: Color):
	super(pos, vel, rot_vel, mass, radius, color)
	self.energy = energy
