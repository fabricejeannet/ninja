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
var prepared_spell
var can_fire:bool = true
var can_move:bool = true
var has_focus:bool = true

var health_bar:ProgressBar
var mana_bar:ProgressBar

onready var FireBall = preload("res://scenes/FireBall.tscn")
onready var Henge = preload("res://scenes/Henge.tscn")
onready var Bunshin = preload("res://scenes/Bunshin.tscn")
onready var sight = $Sight/Sprite
onready var mana:ManaNode = $ManaNode
onready var health:HealthNode = $HeatlhNode


onready var animation_player:AnimationPlayer = $AnimationPlayer

func _ready():
	mana_bar = get_parent().get_parent().get_node("CharacterStats/Control/ManaBar")
	health_bar =  get_parent().get_parent().get_node("CharacterStats/Control/HealthBar")
	
	#warning-ignore:return_value_discarded
	mana.connect("mana_updated", mana_bar, "update_values")
	#warning-ignore:return_value_discarded
	health.connect("health_updated", health_bar, "update_values")	

func _physics_process(_delta):
	var motion = compute_motion()
	set_orientation_according_to(motion)
	play_animation_corresponding_to_orientation()
	#warning-ignore:return_value_discarded
	if has_focus:
		move_and_slide(motion)


func compute_motion() -> Vector2:
	
	if !can_move:
		return Vector2(0,0)
		
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


func get_animation_player() -> AnimationPlayer:
	return animation_player;


func takes_damage(amount:int) -> void:
	health.consume(amount)


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



func _unhandled_input(event):
	if event is InputEventMouseButton:
		cast()


func cast() -> void:
	if !can_fire :
		return
	
	if !prepared_spell:
		return 	
		
	var instance = prepared_spell.instance()
	
	if !mana.is_enough_to_cast(instance.get_cost()) :
		print("Not enough mana (" + str(mana.current_points) + "), cannot cast spell (" + str(instance.get_cost()) + ")!")
		return
		
	get_tree().get_root().add_child(instance)
	instance.cast(self, sight.global_position)
	mana.consume(instance.get_cost())
	
	can_fire = false
	yield(get_tree().create_timer(0.2), "timeout")
	can_fire = true



func _on_katon_button_pressed():
	print("Katon prepared.")
	prepare_to_cast(FireBall)

func _on_henge_button_pressed():
	print("Casting Henge")
	prepare_to_cast(Henge)
	cast()
	
func _on_bunshin_button_pressed():
	print("Casting Bunshin")
	prepare_to_cast(Bunshin)

	
