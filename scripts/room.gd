extends StaticBody3D

const ROOM_WIDTH = 10.0
const ROOM_HEIGHT = 3.0
const WALL_THICKNESS = 0.3

func _ready():
	build_room()

func create_wall(pos: Vector3, size: Vector3, color: Color) -> void:
	var col = CollisionShape3D.new()
	var shape = BoxShape3D.new()
	shape.size = size
	col.shape = shape
	col.position = pos
	add_child(col)
	
	var mesh_instance = MeshInstance3D.new()
	var mesh = BoxMesh.new()
	mesh.size = size
	var material = StandardMaterial3D.new()
	material.albedo_color = color
	mesh_instance.material_override = material
	mesh_instance.position = pos
	mesh_instance.mesh = mesh
	add_child(mesh_instance)

func build_room() -> void:
	var w = ROOM_WIDTH
	var h = ROOM_HEIGHT
	var t = WALL_THICKNESS
	
	# Chão
	create_wall(Vector3(0, 0, 0), Vector3(w, t, w), Color.GRAY)
	# Teto
	create_wall(Vector3(0, h, 0), Vector3(w, t, w), Color.WHITE)
	# Parede esquerda
	create_wall(Vector3(-w/2, h/2, 0), Vector3(t, h, w), Color.RED)
	# Parede direita
	create_wall(Vector3(w/2, h/2, 0), Vector3(t, h, w), Color.BLUE)
	# Parede frontal
	create_wall(Vector3(0, h/2, -w/2), Vector3(w, h, t), Color.GREEN)
	# Parede traseira
	create_wall(Vector3(0, h/2, w/2), Vector3(w, h, t), Color.YELLOW)
