extends NodeState
@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D
@export var ray_cast_2d : RayCast2D
@export var speed : int 
@export var size : int = 24
var direction = -1
var player : CharacterBody2D 
var has_floor = true
func on_process(delta:float):
	pass
func on_physics_process(delta:float):
	if character_body_2d.global_position > player.global_position:
			animated_sprite_2d.flip_h = true
			animated_sprite_2d.position.x= -12
			direction = -1
	elif character_body_2d.global_position < player.global_position:
			animated_sprite_2d.flip_h = false
			animated_sprite_2d.position.x= 14
			direction = 1
	ray_cast_2d.position.x = size * direction
	if ray_cast_2d.is_colliding():
		animated_sprite_2d.play("walk")
		character_body_2d.velocity.x += direction * speed
		character_body_2d.velocity.x = clamp(character_body_2d.velocity.x,-speed, speed)
		character_body_2d.move_and_slide()
	elif !ray_cast_2d.is_colliding():
		character_body_2d.velocity.x = 0
		character_body_2d.move_and_slide()
		animated_sprite_2d.play("idle")
func enter():
	player = get_tree().get_nodes_in_group("Player")[0] as CharacterBody2D
	ray_cast_2d.position.x = size * direction
	ray_cast_2d.enabled = true
func exit():
	ray_cast_2d.enabled = false
