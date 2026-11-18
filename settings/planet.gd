class_name Planet

var name
var pos
var vel
var mass
var radius
var luminance
var color
var texture_path

# Called when the node enters the scene tree for the first time.
func _init(name, pos, vel, mass, radius, luminance, color, texture_path):
	self.name = name
	self.pos = pos
	self.vel = vel
	self.mass = mass
	self.radius = radius
	self.luminance = luminance
	self.color = color
	self.texture_path = texture_path
