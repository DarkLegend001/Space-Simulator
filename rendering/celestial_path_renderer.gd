class_name CelestialPathRenderer extends Node3D

@export var color: Color
@export var radius := 1e-3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func normalized_points(prev_point: Vector3, point: Vector3) -> Array:
	var points := Array()
	var camera_distance = point.distance_to($"../../Camera3D".position)
	var normal := (point - prev_point).normalized()
	var right = normal.cross(Vector3.UP) * (radius * camera_distance)
	var left = -right
	var up = normal.cross(point.normalized()) * (radius * camera_distance)
	var down = -up
	
	points.append(point + up + left)
	points.append(point + up + right)
	points.append(prev_point + up + left)
	points.append(prev_point + up + right)
	points.append(prev_point + up + right)
	
	points.append(prev_point + down + right)
	points.append(point + up + right)
	points.append(point + down + right)
	points.append(point + down + right)
	
	points.append(point + down + left)
	points.append(prev_point + down + right)
	points.append(prev_point + down + left)
	points.append(prev_point + down + left)
	
	points.append(prev_point + up + left)
	points.append(point + down + left)
	points.append(point + up + left)
	
	return points

func generate_mesh(curve: Array):
	var mesh = ImmediateMesh.new()
	var prev_point = null
	mesh.surface_begin(Mesh.PRIMITIVE_TRIANGLE_STRIP)
	for point in curve:
		point /= Globals.distance_scale
		
		if prev_point == null:
			prev_point = point
			continue
		
		for points in normalized_points(prev_point, point):
			mesh.surface_add_vertex(points)
		
		prev_point = point
	
	mesh.surface_end()
	$Mesh.mesh = mesh
