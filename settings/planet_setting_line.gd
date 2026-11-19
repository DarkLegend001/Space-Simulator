extends HBoxContainer

var planet
const SI_distance_constant = 1
const SI_mass_constant = 1
const precision = 4

func reset_values() -> void:
	$NameLineEdit.text = planet.name
	$XPosLineEdit.text = float_to_scientific_string(planet.pos.x / SI_distance_constant)
	$YPosLineEdit.text = float_to_scientific_string(planet.pos.y / SI_distance_constant)
	$ZPosLineEdit.text = float_to_scientific_string(planet.pos.z / SI_distance_constant)
	$XVelLineEdit.text = float_to_scientific_string(planet.vel.x / SI_distance_constant)
	$YVelLineEdit.text = float_to_scientific_string(planet.vel.y / SI_distance_constant)
	$ZVelLineEdit.text = float_to_scientific_string(planet.vel.z / SI_distance_constant)
	$MassLineEdit.text = float_to_scientific_string(planet.mass / SI_mass_constant)
	$RadiusLineEdit.text = float_to_scientific_string(planet.radius / SI_distance_constant)
	$LuminanceLineEdit.text = float_to_scientific_string(planet.luminance)
	$ColorPickerButton.color = planet.color
	$TexturePathEdit.text = "null" #planet.texture

func confirm_values() -> bool:
	if ($XPosLineEdit.text.is_valid_float() and 
			$YPosLineEdit.text.is_valid_float() and 
			$ZPosLineEdit.text.is_valid_float() and
			$XVelLineEdit.text.is_valid_float() and
			$YVelLineEdit.text.is_valid_float() and
			$ZVelLineEdit.text.is_valid_float() and
			$MassLineEdit.text.is_valid_float() and
			$RadiusLineEdit.text.is_valid_float() and
			$LuminanceLineEdit.text.is_valid_float()
		):
		planet.name = $NameLineEdit.text
		planet.pos.x = float($XPosLineEdit.text) * SI_distance_constant
		planet.pos.y = float($YPosLineEdit.text) * SI_distance_constant
		planet.pos.z = float($ZPosLineEdit.text) * SI_distance_constant
		planet.vel.x = float($XVelLineEdit.text) * SI_distance_constant
		planet.vel.y = float($YVelLineEdit.text) * SI_distance_constant
		planet.vel.z = float($ZVelLineEdit.text) * SI_distance_constant
		planet.mass = float($MassLineEdit.text) * SI_mass_constant
		planet.radius = float($RadiusLineEdit.text) * SI_distance_constant
		planet.luminance = float($LuminanceLineEdit.text)
		planet.color = $ColorPickerButton.color
		#planet.texture = $TexturePathEdit.text
		return true
	return false


func float_to_scientific_string(f: float) -> String:
	if (f < 1000 and f > -1000):
		return str(f)
	var return_string = str(f).replace(".","")
	if (f >= 0): return_string = return_string.insert(1,".")
	else: return_string = return_string.insert(2,".")
	return_string = return_string.substr(0, precision + 2)
	return return_string + "e" + str(int(floor(log(abs(f)) / log(10))))
