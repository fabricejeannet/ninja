class_name Spell
extends Node2D

export var cost:int = 15 setget set_cost, get_cost

func get_cost() -> int:
	return cost


func set_cost(_cost:int) -> void :
	cost = _cost

