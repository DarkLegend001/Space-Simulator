extends Camera3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func move(dir: Vector3):
	position += dir

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var change = delta * 1e5 / Globals.distance_scale
	var speed = Vector3.ZERO
	var rot_change = delta * 1
	var rot_speed = Vector3.ZERO
	if Input.is_action_pressed("camera_right"):
		speed.x += change
	if Input.is_action_pressed("camera_left"):
		speed.x -= change
	if Input.is_action_pressed("camera_up"):
		speed.y += change
	if Input.is_action_pressed("camera_down"):
		speed.y -= change
	if Input.is_action_pressed("camera_forward"):
		speed.z -= change
	if Input.is_action_pressed("camera_back"):
		speed.z += change
	
	if Input.is_action_pressed("camera_rotate_right"):
		rot_speed.x -= rot_change
	if Input.is_action_pressed("camera_rotate_left"):
		rot_speed.x += rot_change
	if Input.is_action_pressed("camera_rotate_up"):
		rot_speed.y += rot_change
	if Input.is_action_pressed("camera_rotate_down"):
		rot_speed.y -= rot_change
	if Input.is_action_pressed("camera_roll_right"):
		rot_speed.z += rot_change
	if Input.is_action_pressed("camera_roll_left"):
		rot_speed.z -= rot_change
	
	move(transform.basis * speed)
	rotate_object_local(Vector3.UP, rot_speed.x)
	rotate_object_local(Vector3.RIGHT, rot_speed.y)
	rotate_object_local(Vector3.FORWARD, rot_speed.z)
