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

var health_points = 100 setget set_health_points, get_health_points
var mana_points = 100 setget set_mana_points, get_mana_points
var prepared_spell:Spell setget set_prepared_spell, get_prepared_spell

var animation_player:AnimationPlayer

var can_fire:bool = true

onready var FireBall = preload("res://scenes/FireBall.tscn")
onready var mana_timer = $ManaTimer
onready var sight = $Sight/Sprite

func _ready():
	animation_player = get_node("AnimationPlayer")
	mana_timer.wait_time = 1.0
	mana_timer.connect("timeout", self, "recover_mana")
	prepare_to_cast_fire_ball()

func _physics_process(_delta):
	var motion = compute_motion()
	set_orientation_according_to(motion)
	play_animation_corresponding_to_orienation()
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


func play_animation_corresponding_to_orienation() -> void:
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


func get_max_health_points() -> int:
	return max_health_points


func set_max_health_points(hp:int) -> void:
	max_health_points = hp


func get_mana_points() -> int :
	return mana_points


func set_mana_points(mana:int) -> void:
	mana_points = mana


func get_max_mana_points() -> int :
	return max_mana_points


func set_max_mana_points(mana:int) :
	max_mana_points = mana


func get_animation_player() -> AnimationPlayer:
	return animation_player;


func takes_damage(amount:int) -> void:
	health_points -= amount
	if health_points < 0:
		set_health_points(0)


func heal(amount:int) -> void:
	health_points += amount
	if health_points > max_health_points:
		set_health_points(get_max_health_points())


func use_mana_points(amount:int) -> void:
	if amount <= get_mana_points():
		mana_points -= amount
#		mana_timer.start(1.0)


func get_mana_timer() -> Timer :
	return mana_timer

func get_orientation() :
	return orientation


func add_dot(dot:Dot) -> void:
	#warning-ignore:return_value_discarded
	dot.connect("dot_ticked", self, "on_dot_tick")


func on_dot_tick(amount) -> void:
	takes_damage(amount)




	
func prepare_to_cast_fire_ball() -> void:
	pass



func set_prepared_spell(spell:Spell) -> void:
	prepared_spell = spell


func get_prepared_spell() -> Spell:
	return prepared_spell


func cast(mouse_pointer:Vector2) -> void:
	if can_fire :
		var instance = FireBall.instance()
		set_prepared_spell(instance)
		get_tree().get_root().call_deferred("add_child",instance)
		instance.position = sight.global_position
		instance.rotate(get_angle_to(mouse_pointer))

		instance.get_node("SpellAnimationPlayer").play("shooting")
		instance.set_motion((mouse_pointer - position).normalized())
		instance.set_shot(true)
		
		get_tree().get_root().call_deferred("add_child",instance)
				
		can_fire = false
		yield(get_tree().create_timer(0.2), "timeout")
		can_fire = true
	#	prepared_spell.get_animation_player().play("shooting")
	#	
	
