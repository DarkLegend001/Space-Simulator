extends Control

var selected_body
var follow_body
var previous_toggle

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	selected_body = null
	follow_body = null

func _unhandled_input(event):
	if event is InputEventMouseButton and Input.is_action_pressed("select_thing"):
		var mouse_pos = get_viewport().get_mouse_position()
		var found = false
		for body in $"../CelestialBodies".get_children():
			var planet_pos = $"../Camera3D".unproject_position(body.get_child(0).position)
			if abs(mouse_pos.x - planet_pos.x) < 20 and abs(mouse_pos.y - planet_pos.y) < 20:
				selected_body = body
				$FollowButton.button_pressed = selected_body.get_child(0).following
				previous_toggle = $FollowButton.button_pressed
				found = true
				break
		if not found:
			selected_body = null

func handle_follow():
	if previous_toggle != $FollowButton.button_pressed:
		previous_toggle = $FollowButton.button_pressed
		if $FollowButton.button_pressed:
			for body in $"../CelestialBodies".get_children():
				body.get_child(0).following = false
			follow_body = selected_body
			follow_body.get_child(0).following = true
		else:
			for body in $"../CelestialBodies".get_children():
				body.get_child(0).following = false
			follow_body = null

func update_labels():
	if selected_body == null:
		$Label0.text = ""
		$Label1.text = ""
		$Label2.text = ""
		$Label3.text = ""
		$Label4.text = ""
		$Label5.text = ""
		$Label6.text = ""
	else:
		$Label0.text = selected_body.sim_body.name
		if $OrbitalDisplayButton.button_pressed and follow_body != null:
			var selected_sim_body = selected_body.sim_body
			var follow_sim_body = follow_body.sim_body
			var elements = PhysicsCalculator.get_elements((selected_sim_body.pos - follow_sim_body.pos), (selected_sim_body.vel - follow_sim_body.vel), follow_sim_body.mass, selected_sim_body.mass)
			$Label1.text = "Semi-Major Axis: " + PhysicsCalculator.get_scientific_notation(elements["semi-major axis"])
			$Label2.text = "Eccentricity: " + str(snapped(elements["eccentricity"], 1e-3))
			$Label3.text = "Inclination: " + str(snapped(elements["inclination"], 1e-3))
			$Label4.text = "Right Ascension: " + str(snapped(elements["right ascension"], 1e-3))
			$Label5.text = "Perigee: " + str(snapped(elements["perigee"], 1e-3))
			$Label6.text = "True Anomaly: " +str(snapped(elements["true anomaly"], 1e-3))
		else:
			$Label3.text = ""
			$Label4.text = ""
			$Label5.text = ""
			$Label6.text = ""
			if follow_body == null:
				$Label1.text = "Position: " + str(selected_body.sim_body.pos)
				$Label2.text = "Distance: " + PhysicsCalculator.get_scientific_notation(selected_body.sim_body.pos.length())
				$Label3.text = "Velocity: " + str(selected_body.sim_body.vel)
				$Label4.text = "Speed: " + PhysicsCalculator.get_scientific_notation(selected_body.sim_body.vel.length())
			else:
				$Label1.text = "Position: " + str(selected_body.sim_body.pos - follow_body.sim_body.pos)
				$Label2.text = "Distance: " + PhysicsCalculator.get_scientific_notation((selected_body.sim_body.pos - follow_body.sim_body.pos).length())
				$Label3.text = "Velocity: " + str(selected_body.sim_body.vel - follow_body.sim_body.vel)
				$Label4.text = "Speed: " + PhysicsCalculator.get_scientific_notation((selected_body.sim_body.vel - follow_body.sim_body.vel).length())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if selected_body == null: 
		visible = false
	else:
		visible = true
		handle_follow()
		update_labels()
