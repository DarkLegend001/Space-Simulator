extends Node

# Defines how many metres corresponds with one position unit of Godot
@export var distance_scale: int = 1e3
@export var size_scale: int = 1e7
# Value from 0 to 1 that defines how much the planets scale with distance from the camera
# 1 means planets always appear the same size, 0 means planets have realistic sizes with no scaling. Values less than 
@export var planet_scaling: float = 1
