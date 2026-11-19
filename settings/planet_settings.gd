extends Control

var child_lines = Array()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ExitButton.pressed.connect(exit_settings)
	$SubmitButton.pressed.connect(submit_changes)
	$AddPlanetButton.pressed.connect(add_planet)
	
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
	if (Input.is_action_just_released("ui_cancel")):
		get_tree().change_scene_to_file("res://main/main.tscn")

func submit_changes() -> void:
	var fail_text = "Planets that failed to change: "
	var any_fail = false
	var new_child_fail = false
	for child in child_lines:
		new_child_fail = false
		if (!weakref(child).get_ref()):
			child_lines.erase(child)
			continue
		if (child.planet == null):
			if (child.create_planet() == null):
				new_child_fail = true
		if (!child.confirm_values()):
			any_fail = true
			if (!new_child_fail):
				fail_text += child.planet.name + " "
			else:
				fail_text += "NULL "
	if (any_fail):
		$SubmitFailLabel.text = fail_text
	else:
		$SubmitFailLabel.text = "All changes successful"

func add_planet() -> void:
	var new_line = preload("planet_setting_line.tscn").instantiate()
	child_lines.append(new_line)
	$PlanetLineParent.add_child(new_line)

func exit_settings() -> void:
	get_tree().change_scene_to_file("res://main/main.tscn")
