extends KinematicBody2D

const MOTION_SPEED = 200 # Pixels/second.

enum Orientations {
	NORTH,
	EAST,
	SOUTH,
	WEST,
	NEUTRAL
}

var orientation

export var max_health_points = 100 setget set_max_health_points, get_max_health_points 
export var max_mana_points = 100 setget set_max_mana_points, get_max_mana_points
export var mana_recovery_rate = 0.1
export var health_recovery_rate = 0.1

var health_points = 100 setget set_health_points, get_health_points
var mana_points setget set_mana_points, get_mana_points
var prepared_spell

var animation_player:AnimationPlayer

var can_fire:bool = true

onready var FireBall = preload("res://scenes/FireBall.tscn")
onready var mana_timer = $ManaTimer
onready var health_timer = $HealthTimer
onready var sight = $Sight/Sprite
onready var mana_bar = $Control/ManaBar
onready var health_bar = $Control/HealthBar


func _ready():
	animation_player = get_node("AnimationPlayer")
	
	mana_timer.wait_time = 1.0
	mana_timer.connect("timeout", self, "recover_mana")
	
	health_timer.wait_time = 1.0
	health_timer.connect("timeout", self, "recover_health")
	
	set_mana_points(max_mana_points)
	set_health_points(max_health_points)
	
	prepare_to_cast(FireBall)


func _physics_process(_delta):
	var motion = compute_motion()
	set_orientation_according_to(motion)
	play_animation_corresponding_to_orientation()
	#warning-ignore:return_value_discarded
	move_and_slide(motion)


func compute_motion() -> Vector2:
	var motion = Vector2()
	motion.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	motion.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	motion.y /= 2
	motion = motion.normalized() * MOTION_SPEED
	return motion


func set_orientation_according_to(motion:Vector2):
	if motion.x == 0 and motion.y == 0:
		orientation = Orientations.NEUTRAL
		return
	if motion.y > 0 and motion.x == 0 :
		orientation = Orientations.SOUTH
		return
	if motion.y < 0 and motion.x == 0 :
		orientation = Orientations.NORTH
		return
	if motion.x > 0 and motion.y == 0 :
		orientation = Orientations.EAST
		return
	if motion.x < 0 and motion.y == 0 :
		orientation = Orientations.WEST
		return
	if motion.x > 0 and motion.y > 0 :
		orientation = Orientations.EAST
		return
	if motion.x < 0 and motion.y > 0 :
		orientation = Orientations.WEST
		return
	if motion.x > 0 and motion.y < 0 :
		orientation = Orientations.EAST
		return
	if motion.x < 0 and motion.y < 0 :
		orientation = Orientations.WEST
		return


func play_animation_corresponding_to_orientation() -> void:
	match orientation:
		Orientations.EAST:
			animation_player.play("walk_right")
		Orientations.WEST:
			animation_player.play("walk_left")
		Orientations.NORTH:
			animation_player.play("walk_up")
		Orientations.SOUTH:
			animation_player.play("walk_down")
		Orientations.NEUTRAL:
			animation_player.play("idle")	


func get_health_points() -> int :
	return health_points


func set_health_points(hp:int) -> void:
	health_points = hp
	health_bar.value = health_points


func get_max_health_points() -> int:
	return max_health_points


func set_max_health_points(hp:int) -> void:
	max_health_points = hp
	health_bar.max_value = max_health_points


func get_mana_points() -> int :
	return mana_points


func set_mana_points(mana:int) -> void:
	mana_points = mana
	mana_bar.value = mana_points


func get_max_mana_points() -> int :
	return max_mana_points


func set_max_mana_points(mana:int) :
	max_mana_points = mana
	mana_bar.max_value = max_mana_points


func increase_mana(value:int) -> void:
	set_mana_points(mana_points + value)


func consume_mana(value:int) -> void:
	set_mana_points(mana_points - value)
	mana_timer.start()


func recover_mana() -> void :
	increase_mana(mana_recovery_rate * max_mana_points)
	if mana_points >= max_mana_points:
		mana_timer.stop()


func get_animation_player() -> AnimationPlayer:
	return animation_player;


func takes_damage(amount:int) -> void:
	health_points -= amount
	if health_points < 0:
		set_health_points(0)
	health_timer.start()


func increase_health(value:int) -> void:
	set_health_points(health_points + value)


func recover_health() -> void :
	increase_health(health_recovery_rate * max_health_points)
	if health_points >= max_health_points:
		health_timer.stop()


func heal(amount:int) -> void:
	health_points += amount
	if health_points > max_health_points:
		set_health_points(get_max_health_points())


func has_enough_mana_to_cast(spell:Spell) -> bool:
	return spell.get_cost() <= get_mana_points()


func get_mana_timer() -> Timer :
	return mana_timer

func get_orientation() :
	return orientation


func add_dot(dot:Dot) -> void:
	#warning-ignore:return_value_discarded
	dot.connect("dot_ticked", self, "on_dot_tick")


func on_dot_tick(amount) -> void:
	takes_damage(amount)


func prepare_to_cast(spell) -> void:
	prepared_spell = spell


func get_prepared_spell():
	return prepared_spell


func cast(mouse_pointer:Vector2) -> void:
	if !can_fire :
		return

	var instance = prepared_spell.instance()
	
	if !has_enough_mana_to_cast(instance) :
		return
		
	get_parent().call_deferred("add_child",instance)
	instance.position = sight.global_position
	instance.rotate(get_angle_to(mouse_pointer))
	instance.get_node("SpellAnimationPlayer").play("shooting")
	instance.set_motion((mouse_pointer - position).normalized())
	instance.set_shot(true)
	
	consume_mana(instance.get_cost())
	
	can_fire = false
	yield(get_tree().create_timer(0.2), "timeout")
	can_fire = true

