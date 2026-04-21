extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const MOUSE_SENSIVITY = 0.003

@onready var camera = $Camera3D

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * MOUSE_SENSIVITY)
		camera.rotate_x(-event.relative.y * MOUSE_SENSIVITY)
		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)
