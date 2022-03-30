extends "res://addons/gut/test.gd"

var Mana = preload("res://scripts/ManaNode.gd")
var mana

func before_each():
	mana = Mana.new()
	mana.recovery_rate = 0.1
	mana.max_points = 100

func test_mana_is_correctly_initialized() -> void :
	assert_eq(mana.max_points, 100)
	assert_eq(mana.current_points, mana.max_points)


func test_mana_emits_signal_when_max_points_is_updated() -> void:
	watch_signals(mana)
	mana.set_max_points(90)
	gut.p('-- passing --')
	assert_signal_emitted(mana, "mana_updated")
	
