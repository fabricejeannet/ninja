extends StaticBody2D

var on_fire:bool = false setget set_on_fire, is_on_fire

onready var fire_particles = $Particles2D


func _on_Area2D_body_entered(body):
	if body is FireBall:
		print ("Hit by a fire ball")
		fire_particles.visible = true
		on_fire = true
		body.call_deferred("queue_free")


func is_on_fire() -> bool:
	return on_fire


func set_on_fire(value:bool) -> void:
	on_fire = value
