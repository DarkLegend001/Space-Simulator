class_name SunSimulation extends CelestialBodySimulation

var energy: float

func _init(pos: Vector3, vel: Vector3, rot_vel: Vector3, mass: float, radius: float, energy: float):
	super(pos, vel, rot_vel, mass, radius)
	self.energy = energy
