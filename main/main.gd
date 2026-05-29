extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("start")
	var array = EfficientArray.new()
	array.resize(10)
	array.fill(0)
	for i in range(10):
		array.append_pop(i)
	array.insert_pop(20)
	print(array.get_data())
	print(array.get_value(0))
	print(array.get_value(1))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
