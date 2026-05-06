class_name SunRenderer extends CelestialBodyRenderer

func _ready():
	super()
	following = true
	scale = Vector3.ONE * (sim_body.radius / Globals.size_scale)
	$Light.light_energy = sim_body.energy

func _process(delta: float):
	super(delta)
