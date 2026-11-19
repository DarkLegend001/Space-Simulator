extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TimeStepSlider.value = Globals.timestep
	$GameSpeedSlider.value = Globals.speed
	$PredictionLengthSlider.value = Globals.prediction_length
	$PredictionTimeSlider.value = Globals.prediction_timestep
	$StoreNumSlider.value = Globals.num_prev_positions
	$StoreSpeedSlider.value = Globals.store_speed

func handle_paused() -> void:
	get_tree().paused = $PauseButton.button_pressed

func handle_gamespeed() -> void:
	Globals.speed = $GameSpeedSlider.value
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

func handle_visible() -> void:
	if ($"../ShowSettingsButton".button_pressed):
		$"../Settings".visible = true
	else:
		$"../Settings".visible = false

func handle_misc_variables() -> void:
	Globals.prediction_length = $PredictionLengthSlider.value
	Globals.prediction_timestep = $PredictionTimeSlider.value
	Globals.store_speed = $StoreSpeedSlider.value
	Globals.num_prev_positions = $StoreNumSlider.value

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handle_paused()
	handle_gamespeed()
	handle_background()
	handle_lighting()
	handle_visible()
	handle_misc_variables()
