extends Node

var network = NetworkedMultiplayerENet.new()

export var server_ip:String = "10.0.0.7"
export var port:int = 1909

func _ready():
	 connect_to_server()

func connect_to_server() -> void:
	network.create_client(server_ip, port)
	get_tree().set_network_peer(network)
	
	network.connect("connection_failed", self, "_on_connection_failed")
	network.connect("connection_succeeded", self, "_on_connection_succeeded")
	
func _on_connection_failed() -> void:
	print("Failed to connect")

func _on_connection_succeeded() -> void:
	print("Succesfuly connected")
	
func fetch_spell_damage(spell_name, requester):
	rpc_id(1, "fetch_spell_damage", spell_name, requester)
	
remote func return_spell_damage(var damage_from_server, requester) :
	instance_from_id(requester).set_damage(damage_from_server)
