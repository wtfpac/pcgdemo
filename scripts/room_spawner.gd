extends Node

const ROOM_SCENE = preload("res://scenes/room.tscn") #carrega a cena da sala que criamos, preload garante que a cena é carregada antes do jgoo rodar
const ROOM_SIZE = Vector3(10, 3, 10) #tamanho d cada sala, msm valor que boxmesh
const ROOM_SPACING = 2.0 #espaço extra entre as salas p nao ficar grudada

var placed_rooms: Dictionary = {} #dicionario q vai guardar a posiçao d cada sala no mundo, chave = id

func find_valid_position(room_id: int) -> Vector3: # tenta encontrar posição valida, a 1° sala sempr vai ser centro Vector3.ZERO. as demias tentam ate 100 pos aleatorias, se nao achar pos valida, coloca sequencia como fallback
	var step = ROOM_SIZE.x + ROOM_SPACING #step é o tamanho da sala mais espaçamento usado p calcular pos na grade
	
	if room_id == 0:
		return Vector3.ZERO
	
	var attempts = 0
	while attempts < 100:
		var random_pos = Vector3(
			randi_range(-5, 5) * step,
			0,
			randi_range(-5, 5) * step
		)
		
		if not is_overlapping(random_pos):
			return random_pos
			
		attempts +=1
		
	return Vector3(room_id * step, 0, 0)

func is_overlapping(pos: Vector3) -> bool: #REGRA ESPACIAL > verific se a pos candidata sobrepoe alguma sala colocada, percorre todas pos e checa se distancia é menor que tamanho da sala + espaçamento
	for placed_pos in placed_rooms.values():
		if pos.distance_to(placed_pos) < ROOM_SIZE.x + ROOM_SPACING:
			return true
	return false
	
func spawn_rooms(graph: Node) -> void: #para cada sala, encontra pos valida, registra no dicionario placed_rooms, instancia a cena, posiciona no mundo e adiciona como filho desse nó
	for room in graph.rooms:
		var pos = find_valid_position(room.id)
		placed_rooms[room.id] = pos
		var room_instance = ROOM_SCENE.instantiate()
		room_instance.position = pos
		room_instance.name = "Room_" + str(room.id) #nomeia sala com id p DEBUGAR, ex: room_0, room_1 etc
		add_child(room_instance)
