extends Node
class_name ManaNode

signal mana_updated

export var recovery_rate:float
export var max_points:int

var current_points:int


onready var mana_timer = $ManaTimer


func _ready() -> void:
	_set_current_points(max_points)
	print("Initializing mana node. Max : " + str(max_points) + " current : " + str(current_points))

func get_max_points() -> int :
	return max_points


func set_max_points(mana:int) :
	max_points = mana
	print("Max mana points is now " + str(max_points))
	emit_signal("mana_updated", max_points, current_points)


func increase(value:int) -> void:
	_set_current_points(current_points + value)


func consume(value:int) -> void:
	_set_current_points(current_points - value)


func _set_current_points(value:int) -> void:
	current_points = value
	emit_signal("mana_updated", max_points, current_points)
	mana_timer.start()


func recover() -> void :
	increase(int(recovery_rate * float(max_points)))
	if current_points >= max_points:
		mana_timer.stop()


func is_enough_to_cast(value:int) -> bool:
	return value <= current_points



