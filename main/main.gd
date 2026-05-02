extends Node

var control = preload("res://controller/simulation_controller.tscn")
var controller

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Starting scene 'main'")
	# controller = control.instantiate()
	# self.add_child(controller)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
