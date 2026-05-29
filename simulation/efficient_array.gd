class_name EfficientArray

var data: Array
var index := 0

func _init():
	data = Array()

func resize(size: int):
	data.resize(size)

func size() -> int:
	return data.size()

func duplicate() -> EfficientArray:
	var clone = EfficientArray.new()
	clone.data = data.duplicate()
	clone.index = index
	return clone

func fill(value):
	for i in range(data.size()):
		data[i] = value

## removes oldest value and replaces it with a new value
func push_pop(new_value):
	var old_value = data[index]
	data[index] = new_value
	index += 1
	if index == data.size():
		index = 0
	return old_value

## gets the value at an index
func get_value(value_index):
	return data[value_index + index] if value_index + index < data.size() else data[value_index + index - data.size()]

func set_value(value_index, value):
	var adjusted_index = value_index + index if value_index + index < data.size() else value_index + index - data.size()
	data[adjusted_index] = value

func get_data() -> Array:
	var return_array = Array()
	var return_index = index
	return_array.resize(data.size())
	for i in range(return_array.size()):
		return_array[i] = data[return_index + i]
		if return_index + i == data.size() - 1:
			return_index -= data.size()
	
	return return_array
