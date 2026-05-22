class_name CelestialPathRenderer extends Node3D

@export var color: Color
@export var radius := 0.02

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func normalized_points(prev_point: Vector3, point: Vector3) -> Array:
	var points := Array()
	var normal := (point - prev_point).normalized()
	var right = normal.cross(Vector3.UP) * radius
	var left = -right
	var up = normal.cross(point.normalized()) * radius
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
	for point in curve:
		point /= Globals.distance_scale
		if prev_point == null:
			prev_point = point
			continue
		
		mesh.surface_begin(Mesh.PRIMITIVE_TRIANGLE_STRIP)
		for points in normalized_points(prev_point, point):
			mesh.surface_add_vertex(points)
		mesh.surface_end()
		
		prev_point = point
	
	$Mesh.mesh = mesh
