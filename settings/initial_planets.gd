class_name InitialPlanets

static var planets

static func clear() -> void:
	planets = Array()

static func reset() -> void:
	clear()
	var file = FileAccess.open("res://data/presets.txt", FileAccess.READ)
	var contents = file.get_as_text().trim_suffix("\n").split("\n")
	for line in contents:
		if line[0] == "#":
			continue
		var elements = line.split(",")
		var title = elements[0]
		var pos = Vector3(float(elements[1]), float(elements[2]), float(elements[3]))
		var vel = Vector3(float(elements[4]), float(elements[5]), float(elements[6]))
		var mass = float(elements[7])
		var radius = float(elements[8])
		var luminance = float(elements[9])
		var color = Color.from_rgba8(int(elements[10]), int(elements[11]), int(elements[12]), int(elements[13]))
		var texture_path = elements[14].strip_edges()
		
		add_planet(title, pos, vel, mass, radius, luminance, color, texture_path)


static func remove_planet(planet) -> void:
	planets.erase(planet)

static func add_planet(name, pos, vel, mass, radius, luminance, color, texture_path) -> Planet:
	var planet = Planet.new(name, pos, vel, mass, radius, luminance, color, texture_path)
	planets.append(planet)
	return planet
