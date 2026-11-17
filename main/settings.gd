extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func handle_paused() -> void:
	get_tree().paused = $PauseButton.button_pressed

func handle_gamespeed() -> void:
	Globals.speed = $GameSpeedSlider.value
	
func handle_gametick() -> void:
	Globals.timestep = $TimeStepSlider.value

func handle_background() -> void:
	if ($BackgroundButton.pressed):
		if ($BackgroundButton.button_pressed):
			$"../WorldEnvironment".environment.background_mode = 1
		else:
			$"../WorldEnvironment".environment.background_mode = 2

func handle_lighting() -> void:
	if ($DynamicLightingButton.button_pressed):
		get_tree().root.debug_draw = Viewport.DEBUG_DRAW_UNSHADED
	else:
		get_tree().root.debug_draw = Viewport.DEBUG_DRAW_DISABLED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handle_paused()
	handle_gamespeed()
	handle_gametick()
	handle_background()
	handle_lighting()
