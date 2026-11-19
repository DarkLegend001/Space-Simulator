extends Control

var child_lines = Array()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var child_scene = preload("planet_setting_line.tscn")
	for planet in InitialPlanets.planets:
		var child = child_scene.instantiate()
		child_lines.append(child)
		child.planet = planet
		child.reset_values()
		$PlanetLineParent.add_child(child)
	$SubmitFailLabel.text = ""


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var fail_text = "Planets that failed to change:\n"
	var any_fail = false
	if ($SubmitButton.button_pressed):
		for child in child_lines:
			if (!child.confirm_values()):
				any_fail = true
				fail_text += child.planet.name + "\n"
		if (any_fail):
			$SubmitFailLabel.text = fail_text
		else:
			$SubmitFailLabel.text = "All changes successful"
	
	if (Input.is_action_just_released("ui_cancel")):
		get_tree().change_scene_to_file("res://main/main.tscn")
