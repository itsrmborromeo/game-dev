extends NodeState
@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var Muzzle : Marker2D
var player : CharacterBody2D
var direction: int
var fireball = preload("res://Anton/final mobs and scripts/mobs and resources/projectiles/fire ball/fireball.tscn")
func on_process(delta:float):
	pass
func on_physics_process(delta:float):
	animated_sprite_2d.play("shoot")
func enter():
	character_body_2d.velocity.x = 0
	player = get_tree().get_nodes_in_group("Player")[0] as CharacterBody2D
	if character_body_2d.global_position > player.global_position:
			animated_sprite_2d.flip_h = true
			animated_sprite_2d.position.x= -12
			Muzzle.position.x = -38
			direction = -1
	elif character_body_2d.global_position < player.global_position:
			animated_sprite_2d.flip_h = false
			animated_sprite_2d.position.x= 14
			Muzzle.position.x = 38
			direction = 1
	character_body_2d.move_and_slide()
func exit():
	var projectile_instance = fireball.instantiate()as Node2D
	projectile_instance.global_position = Muzzle.global_position
	projectile_instance.direction = direction
	character_body_2d.get_parent().add_child(projectile_instance)
