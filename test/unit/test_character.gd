extends "res://addons/gut/test.gd"

var Character = load("res://scripts/Character.gd")
var Dot = load("res://scripts/Dot.gd")
var FireBall = load("res://scenes/FireBall.tscn")
var World = load("res://scenes/TestWorld.tscn")
var hero

func before_each():
	hero = Character.new()
	
#
#func test_character_hp_equals_max_hp():
#	assert_eq(hero.get_health_points(), hero.get_max_health_points())
#
#
#func test_character_can_take_dammage():
#	hero.takes_damage(10)
#	assert_eq(hero.get_health_points(), 90)
#
#
#func test_character_cannot_have_negative_health_points():
#	hero.takes_damage(110)
#	assert_eq(hero.get_health_points(), 0)
#
#
#func test_character_can_heal():
#	hero.takes_damage(30)
#	hero.heal(20)
#	assert_eq(hero.get_health_points(), 90)
#
#
#func test_health_points_cannot_exceed_max_health_points():
#	hero.takes_damage(20)
#	hero.heal(30)
#	assert_eq(hero.get_health_points(), hero.get_max_health_points())
#
#
#func test_dot_decreases_health_when_ticking():
#	var dot = Dot.new (14, 5, 1)
#	hero.add_dot(dot)
#	dot.tick()
#	assert_eq(hero.get_health_points(), 86)
#
#
#func test_character_mana_equals_max_mana():
#	assert_eq(hero.get_mana_points(), hero.get_max_mana_points())
#
#
#func test_using_mana_decreases_total_mana():
#	hero.use_mana_points(10)
#	assert_eq(hero.get_mana_points(), hero.get_max_mana_points() - 10)
#
#
#func test_cannot_use_more_mana_than_what_is_left():
#	hero.use_mana_points(90)
#	assert_eq(hero.get_mana_points(), 10)
#	hero.use_mana_points(11)
#	assert_eq(hero.get_mana_points(), 10)


func test_sets_direction_according_to_motion() -> void :
	var motion = Vector2(0,0)
	hero.set_orientation_according_to(motion)
	assert_eq(hero.get_orientation(), hero.Orientations.NEUTRAL)
	
	motion = Vector2(1,0)
	hero.set_orientation_according_to(motion)
	assert_eq(hero.get_orientation(), hero.Orientations.EAST)

	motion = Vector2(-1,0)
	hero.set_orientation_according_to(motion)
	assert_eq(hero.get_orientation(), hero.Orientations.WEST)
	
	motion = Vector2(0,1)
	hero.set_orientation_according_to(motion)
	assert_eq(hero.get_orientation(), hero.Orientations.SOUTH)
	
	motion = Vector2(0,-1)
	hero.set_orientation_according_to(motion)
	assert_eq(hero.get_orientation(), hero.Orientations.NORTH)
	
	motion = Vector2(1, -1)
	hero.set_orientation_according_to(motion)
	assert_eq(hero.get_orientation(), hero.Orientations.EAST)

	motion = Vector2(-1, 1)
	hero.set_orientation_according_to(motion)
	assert_eq(hero.get_orientation(), hero.Orientations.WEST)
	
	motion = Vector2(-1 , -1)
	hero.set_orientation_according_to(motion)
	assert_eq(hero.get_orientation(), hero.Orientations.WEST)
	
	motion = Vector2(1, 1)
	hero.set_orientation_according_to(motion)
	assert_eq(hero.get_orientation(), hero.Orientations.EAST)


func test_can_prepare_to_shoot_a_fire_ball() -> void:
	hero.prepare_to_cast(FireBall)
	assert_eq(hero.get_prepared_spell(), FireBall)

#func test_casting_a_spell_decreases_mana_points() -> void:
#	var world = World.instance()
#	world.add_child(hero)
#	hero.prepare_to_cast(FireBall)
#	assert_eq(hero.get_mana_points(), hero.get_max_mana_points())
#	hero.cast(Vector2(1,1))
#	assert_eq(hero.get_mana_points(), hero.get_mana_points() - FireBall.get_cost())
#


#func test_mana_increases_when_mana_timer_ticks() -> void:

	

#func test_using_mana_starts_the_mana_timer() -> void:
#	assert_true(hero.get_mana_timer().is_stopped())
#	hero.use_mana_points(50)
#	assert_false(hero.get_mana_timer().is_stopped())

#func test_mana_points_cannot_exceed_max_mana_points():
	

