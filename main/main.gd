extends Node

var control = preload("res://rendering/celestial_body_renderer.tscn")
var controller

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Starting scene 'main'")
	controller = control.instantiate()
	$".".add_child(controller)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
