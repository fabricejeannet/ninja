extends "res://addons/gut/test.gd"

var Sasuke = preload("res://scenes/Sasuke.tscn")
var sasuke

func before_each(): 
	sasuke = Sasuke.instance()
	sasuke._ready()


func test_scene_is_loaded():
	assert_not_null(sasuke)


func test_animation_player_is_loaded():
	assert_not_null(sasuke.get_animation_player())

#
#func test_animation_player():
#	Input.action_press("ui_down", 0.5)
#	assert_eq(sasuke.get_animation_player().current_animation, "walk_down")
	


