extends PlayerNodeState
@export var character_body_2d :CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
func on_process(_delta : float):
	pass


func on_physics_process(_delta : float):
	character_body_2d.set_collision_layer_value(3 , false)
	animated_sprite_2d.play("dead")
func enter():
	pass


func exit():
	pass
