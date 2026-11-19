extends HBoxContainer

var planet

func reset_values() -> void:
	$NameLineEdit.text = str(planet.name)
	$XPosLineEdit.text = str(planet.pos.x)
	$YPosLineEdit.text = str(planet.pos.y)
	$ZPosLineEdit.text = str(planet.pos.z)
	$XVelLineEdit.text = str(planet.vel.x)
	$YVelLineEdit.text = str(planet.vel.y)
	$ZVelLineEdit.text = str(planet.vel.z)
	$MassLineEdit.text = str(planet.mass)
	$RadiusLineEdit.text = str(planet.radius)
	$LuminanceLineEdit.text = str(planet.luminance)
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
		planet.pos.x = float($XPosLineEdit.text)
		planet.pos.y = float($YPosLineEdit.text)
		planet.pos.z = float($ZPosLineEdit.text)
		planet.vel.x = float($XVelLineEdit.text)
		planet.vel.y = float($YVelLineEdit.text)
		planet.vel.z = float($ZVelLineEdit.text)
		planet.mass = float($MassLineEdit.text)
		planet.radius = float($RadiusLineEdit.text)
		planet.luminance = float($LuminanceLineEdit.text)
		planet.color = $ColorPickerButton.color
		#planet.texture = $TexturePathEdit.text
		return true
	return false
