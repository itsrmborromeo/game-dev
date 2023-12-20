extends PlayerNodeState
@export var animated_sprite_2d: AnimatedSprite2D
func on_process(_delta : float):
	pass


func on_physics_process(_delta : float):
	animated_sprite_2d.play("dead")
	if animated_sprite_2d.animation_finished:
		HpManager.regen(100)
func enter():
	pass


func exit():
	pass
