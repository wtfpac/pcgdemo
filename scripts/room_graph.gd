extends Node

class Room: # o que é cada sala
	var id: int # cada sala tem um único id
	var connections: Array = [] 
	
	func _init(room_id: int):
		id = room_id
		
var rooms: Array = [] # array que guarda todas as salas do grafo
var room_count: int = 0 # contador de quantas salas existem

func add_room() -> Room: # cria uma nova sala com id único e adiciona array
	var room = Room.new(room_count)
	rooms.append(room)
	room_count += 1
	return room
	
func connect_rooms(room_a: Room, room_b: Room) -> void: #conecta duas salas entre si, conexão bidirecional
	room_a.connections.append(room_b)
	room_b.connections.append(room_a)
	
func generate(num_rooms: int) -> void: #função principal, cria todas as salas depois conecta cada sala nova com uma sala anterior aleatória
	for i in range(num_rooms):
		add_room()
		
	for i in range(1, room_count):
		var random_previous = randi() % i
		connect_rooms(rooms[i], rooms[random_previous])
		
###### RANDOM SPANNING TREE
