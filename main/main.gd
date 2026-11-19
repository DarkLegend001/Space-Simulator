extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("start")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if (Input.is_action_just_released("ui_cancel")):
		get_tree().change_scene_to_file("res://settings/planet_settings.tscn")
