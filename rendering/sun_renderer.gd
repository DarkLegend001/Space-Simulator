class_name SunRenderer extends CelestialBodyRenderer

func _ready():
	super()
	following = true
	scale = Vector3.ONE * (body.radius / Globals.size_scale)
	$Light.light_energy = body.energy

func set_material():
	pass

func _process(delta: float):
	super(delta)
