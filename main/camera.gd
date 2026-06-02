extends Camera3D

@export var precision := false
@export var precision_mult := 0.05
@export var sensitivity := 1e9 / Globals.distance_scale
@export var rot_sensitivity := 0.0025
@export var pan_sensitivity := 3e8 / Globals.distance_scale
@export var zoom_sensitivity := 4.0
var zoom_side_sensitivity := 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func move(dir: Vector3):
	position += dir

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if Input.is_action_pressed("rotate_camera"):
			rotate_object_local(Vector3.UP, event.screen_relative.x * rot_sensitivity)
			rotate_object_local(Vector3.RIGHT, event.screen_relative.y * rot_sensitivity)
		if Input.is_action_pressed("pan_camera"):
			position += (transform.basis * Vector3(-event.screen_relative.x, event.screen_relative.y, 0) * pan_sensitivity)
	elif event is InputEventMouseButton:
		var speed: Vector3 = Vector3.ZERO
		var mouse_pos = get_viewport().get_mouse_position() - get_viewport().get_visible_rect().size / 2
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			speed.x += mouse_pos.x * zoom_side_sensitivity
			speed.y -= mouse_pos.y * zoom_side_sensitivity
			speed.z -= zoom_sensitivity
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			speed.x -= mouse_pos.x * zoom_side_sensitivity
			speed.y += mouse_pos.y * zoom_side_sensitivity
			speed.z += zoom_sensitivity
		move(transform.basis * speed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var speed = Vector3.ZERO
	var rot_change = delta * 1
	var rot_speed = Vector3.ZERO
	
	zoom_side_sensitivity = 2.775 * zoom_sensitivity / get_viewport().get_visible_rect().size.x
	
	if Input.is_action_pressed("camera_right"):
		speed.x += sensitivity
	if Input.is_action_pressed("camera_left"):
		speed.x -= sensitivity
	if Input.is_action_pressed("camera_up"):
		speed.y += sensitivity
	if Input.is_action_pressed("camera_down"):
		speed.y -= sensitivity
	if Input.is_action_pressed("camera_forward"):
		speed.z -= sensitivity
	if Input.is_action_pressed("camera_back"):
		speed.z += sensitivity
  
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
	
	if (Input.is_action_just_pressed("toggle_camera_precision")):
		precision = !precision
	
	if (precision):
		speed *= precision_mult
	
	move(transform.basis * speed)
	rotate_object_local(Vector3.UP, rot_speed.x)
	rotate_object_local(Vector3.RIGHT, rot_speed.y)
	rotate_object_local(Vector3.FORWARD, rot_speed.z)
