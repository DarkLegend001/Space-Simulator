extends Node

# Defines how many metres corresponds with one position unit of Godot
@export var distance_scale: int = 1e9
@export var size_scale: int = 1e7
# Value from 0 to 1 that defines how much the planets scale with distance from the camera
# 1 means planets always appear the same size, 0 means planets have realistic sizes with no scaling. 
# Values close to 1 can lead to planets becoming invisible when they are too close to the camera 
@export var planet_scaling: float = 0.5


# timesteps per second
@export var speed := 500
# seconds of physics per timestep
@export var timestep := 300

# number of timesteps for each prediction
@export var prediction_length := 500
# seconds of physics per predicted timestep
@export var prediction_timestep := 36000
# predictions per second
@export var prediction_speed := 10
# number of previous positions stored
@export var num_prev_positions := 300
# number of times previous positions are stored per second
@export var store_speed := 1
# number of times previous positions are rendered per second
@export var render_store_speed := 60
