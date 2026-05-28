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
				found = true
				break
		if not found:
			selected_body = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if selected_body == null: 
		visible = false
	else:
		visible = true
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
		
		if selected_body == null:
			$Name.text = ""
			$Position.text = ""
			$Velocity.text = ""
		else:
			$Name.text = selected_body.sim_body.name
			if follow_body == null:
				$Position.text = "Position: " + str(selected_body.sim_body.pos)
				$Velocity.text = "Velocity: " + str(selected_body.sim_body.vel)
			else:
				$Position.text = "Position: " + str(selected_body.sim_body.pos - follow_body.sim_body.pos)
				$Velocity.text = "Velocity: " + str(selected_body.sim_body.vel - follow_body.sim_body.vel)
