extends Node

var network = NetworkedMultiplayerENet.new()

export var server_ip:String = "127.0.0.1"
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
	
	
