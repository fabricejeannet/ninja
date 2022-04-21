extends Node2D

var Server = load("res://scripts/server/Server.gd")


func _ready() :
	print("Starting Game")
	var server = Server.new()
	add_child(server)
