extends "res://addons/gut/test.gd"

var Character = load("res://scripts/Character.gd")
var Dot = load("res://scripts/Dot.gd")
var dot

func before_each():
	dot = Dot.new(10, 1, 5)

func test_dot_lives_until_max_ticks_is_reached():
	for i in 4: # 4 ticks out of 5 
		dot.tick()
	assert_false(dot == null and dot.is_queued_for_deletion())
	
	dot.tick() # last tick
	assert_true(dot == null or dot.is_queued_for_deletion())


func test_dot_emits_signal_when_it_ticks():
	watch_signals(dot)
	dot.tick()
	gut.p('-- passing --')
	assert_signal_emitted(dot, 'dot_ticked')
		

