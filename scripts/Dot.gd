class_name Dot
extends Node2D

signal dot_ticked

export var value = 0	 setget set_value, get_value
export var interval = 0 setget set_interval, get_interval
export var max_ticks = 0 setget set_max_ticks, get_max_ticks

var _tick_count = 0

onready var timer = $Timer

func _init(_value:int, _interval:int, _max_ticks:int):
	set_value(_value)
	set_interval(_interval)
	set_max_ticks(_max_ticks)


func _ready():
	timer.wait_time = interval
	timer.start()


func set_value(_value) :
	value = _value


func get_value() -> int :
	return value


func set_interval(_interval):
	interval = _interval


func get_interval() -> int:
	return interval


func set_max_ticks(_max_ticks:int):
	max_ticks = _max_ticks


func get_max_ticks() -> int:
	return max_ticks


func tick():
	emit_signal("dot_ticked", value)
	_tick_count += 1
	if _tick_count >= max_ticks:
		self.queue_free()
