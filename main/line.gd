extends Node

# This code is from https://www.youtube.com/watch?v=UrENObFwQVo


@onready var mesh: MeshInstance3D = $MeshInstance3D

func draw_line(point_a: Vector3, point_b: Vector3, color: Color):
	if point_a.is_equal_approx(point_b):
		return
	
	if mesh.mesh is ImmediateMesh:
		mesh.mesh.surface_begin(Mesh.PRIMITIVE_LINES)
		mesh.mesh.surface_set_color(color)
		
