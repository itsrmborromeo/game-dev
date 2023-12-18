extends NodeState
@export var character_body_2d : CharacterBody2D
@export var animated_body_2d : AnimatedSprite2D
func on_process(_delta:float):
	pass
func on_physics_process(_delta:float):
	animated_body_2d.play("dead")
func enter():
	character_body_2d.velocity.x = 0
	character_body_2d.move_and_slide()
func exit():
	pass
