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

func _physics_process(delta): ## roda cada frame fisico do jogo, delta = tempo entre frames
	if not is_on_floor(): ## verifica se o jogador está no chao, se não, aplica gravidade
		velocity.y -= 9.8 * delta
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back") ##captura wasd
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized() ##converte a direção do input para o espaço do jogador
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED) ##desacelera quando solta tecla
		velocity.z = move_toward(velocity.z, 0, SPEED) 
		
	move_and_slide()## aplica movimento com detecção de colisão
