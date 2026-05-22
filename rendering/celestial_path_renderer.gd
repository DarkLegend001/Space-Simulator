class_name CelestialPathRenderer extends Node3D

var color: Color
var radius := 0.05

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func generate_mesh(curve: Array):
	var mesh = ImmediateMesh.new()
	var prev_point = null
	for point in curve:
		point /= Globals.distance_scale
		if prev_point == null:
			mesh.surface_begin(Mesh.PRIMITIVE_TRIANGLE_STRIP)
			mesh.surface_add_vertex(Vector3(point.x + radius, point.y + radius, point.z))
			mesh.surface_add_vertex(Vector3(point.x + radius, point.y - radius, point.z))
			mesh.surface_add_vertex(Vector3(point.x - radius, point.y + radius, point.z))
			mesh.surface_add_vertex(Vector3(point.x - radius, point.y - radius, point.z))
			mesh.surface_end()
			prev_point = point
			continue
		mesh.surface_begin(Mesh.PRIMITIVE_TRIANGLE_STRIP)
		mesh.surface_add_vertex(Vector3(point.x - radius, point.y + radius, point.z))
		mesh.surface_add_vertex(Vector3(point.x + radius, point.y + radius, point.z))
		mesh.surface_add_vertex(Vector3(prev_point.x - radius, prev_point.y + radius, prev_point.z))
		mesh.surface_add_vertex(Vector3(prev_point.x + radius, prev_point.y + radius, prev_point.z))
		mesh.surface_end()
		
		mesh.surface_begin(Mesh.PRIMITIVE_TRIANGLE_STRIP)
		mesh.surface_add_vertex(Vector3(point.x - radius, point.y + radius, point.z))
		mesh.surface_add_vertex(Vector3(point.x - radius, point.y - radius, point.z))
		mesh.surface_add_vertex(Vector3(prev_point.x - radius, prev_point.y + radius, prev_point.z))
		mesh.surface_add_vertex(Vector3(prev_point.x - radius, prev_point.y - radius, prev_point.z))
		mesh.surface_end()
		
		mesh.surface_begin(Mesh.PRIMITIVE_TRIANGLE_STRIP)
		mesh.surface_add_vertex(Vector3(point.x - radius, point.y - radius, point.z))
		mesh.surface_add_vertex(Vector3(point.x + radius, point.y - radius, point.z))
		mesh.surface_add_vertex(Vector3(prev_point.x - radius, prev_point.y - radius, prev_point.z))
		mesh.surface_add_vertex(Vector3(prev_point.x + radius, prev_point.y - radius, prev_point.z))
		mesh.surface_end()
		
		mesh.surface_begin(Mesh.PRIMITIVE_TRIANGLE_STRIP)
		mesh.surface_add_vertex(Vector3(point.x + radius, point.y + radius, point.z))
		mesh.surface_add_vertex(Vector3(point.x + radius, point.y - radius, point.z))
		mesh.surface_add_vertex(Vector3(prev_point.x + radius, prev_point.y + radius, prev_point.z))
		mesh.surface_add_vertex(Vector3(prev_point.x + radius, prev_point.y - radius, prev_point.z))
		mesh.surface_end()
		
		prev_point = point
	
	var point = curve[-1]
	mesh.surface_begin(Mesh.PRIMITIVE_TRIANGLE_STRIP)
	mesh.surface_add_vertex(Vector3(point.x + radius, point.y + radius, point.z))
	mesh.surface_add_vertex(Vector3(point.x + radius, point.y - radius, point.z))
	mesh.surface_add_vertex(Vector3(point.x - radius, point.y + radius, point.z))
	mesh.surface_add_vertex(Vector3(point.x - radius, point.y - radius, point.z))
	mesh.surface_end()
	
	
	"""var camera_pos = $"../../Camera3D".position
	mesh.surface_begin(Mesh.PRIMITIVE_TRIANGLE_STRIP)
	mesh.surface_add_vertex(Vector3(camera_pos.x + 1, camera_pos.y + 1, camera_pos.z + 2))
	mesh.surface_add_vertex(Vector3(camera_pos.x + 1, camera_pos.y - 1, camera_pos.z + 2))
	mesh.surface_add_vertex(Vector3(camera_pos.x - 1, camera_pos.y + 1, camera_pos.z + 2))
	mesh.surface_add_vertex(Vector3(camera_pos.x - 1, camera_pos.y - 1, camera_pos.z + 2))
	mesh.surface_end()"""
	
	$Mesh.mesh = mesh
