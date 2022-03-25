extends "res://addons/gut/test.gd"

var FireBall = load("res://scenes/FireBall.tscn")
var fire_ball

func before_each() -> void:
	fire_ball = FireBall.instance()



func test_fire_ball_has_a_cost() -> void :
	assert_true (fire_ball.get_cost() > 0)

#func test_can_be_shot() -> void:
#	var direction:Vector2 =  Vector2(2.0, 2.0)
#	assert_false(fire_ball.is_shot())
#	fire_ball.shoot(direction)
#	assert_true(fire_ball.is_shot())
