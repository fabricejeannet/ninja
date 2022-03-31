extends Node
class_name HealthNode

signal health_updated

export var recovery_rate:float
export var max_points:int

var current_points:int

onready var health_timer = $HealthTimer


func _ready() -> void:
	_set_current_points(max_points)
	print("Initializing health node. Max : " + str(max_points) + " current : " + str(current_points))

func get_max_points() -> int :
	return max_points


func set_max_points(max_health:int) :
	max_points = max_health
	print("Max health points is now " + str(max_points))
	emit_signal("health_updated", max_points, current_points)


func increase(value:int) -> void:
	_set_current_points(current_points + value)


func consume(value:int) -> void:
	_set_current_points(current_points - value)


func _set_current_points(value:int) -> void:
	current_points = value
	emit_signal("health_updated", max_points, current_points)
	health_timer.start()


func recover() -> void :
	increase(int(recovery_rate * float(max_points)))
	if current_points >= max_points:
		health_timer.stop()



