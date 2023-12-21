extends Area2D
@export var SPEED : int = 900
var direction : int 
@export var damage_amount = 10
@onready var animated_sprite_2d = $AnimatedSprite2D

func _physics_process(delta):
	move_local_x(direction*SPEED*delta)
	$AnimatedSprite2D.play("flight")

func _on_timer_timeout():
	queue_free()
