extends Node3D

@onready var room_graph = $RoomGraph #pega ref roomgraph e roomspawner
@onready var room_spawner = $RoomSpawner #qtde salas geradas

const NUM_ROOMS = 5 # 5 salas TESTE

func _ready(): #qnd cena dar load, primeiro gera grafo com 5 salas, dps spawner isntancia salas no mundo c base grafo
	room_graph.generate(NUM_ROOMS)
	room_spawner.spawn_rooms(room_graph)
	spawn_player()
	
func spawn_player() -> void: #pega pos da sala id 0 e posiciona o player 2 und acima dela
	var first_room_pos = room_spawner.placed_rooms[0]
	$player.position = first_room_pos + Vector3(0, 2, 0)
