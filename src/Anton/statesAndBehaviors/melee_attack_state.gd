extends NodeState
@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var strike_zone : Area2D
@export var strike : CollisionShape2D
@export var hit_zone : Marker2D
var player : CharacterBody2D
var strike_direction : int
var direction : int
var counter = 1
func on_process(delta:float):
	pass
func on_physics_process(delta:float):
	animation_handler()
	if character_body_2d.global_position > player.global_position:
		animated_sprite_2d.flip_h = true
		direction = -1
	elif character_body_2d.global_position < player.global_position:
		animated_sprite_2d.flip_h = false
		direction = 1
	hit_zone.position.x = 30 * direction
	if strike.position > hit_zone.position:
		strike_direction = -1
	elif strike.position < hit_zone. position:
		strike_direction = 1
	elif strike.position == hit_zone.position:
		strike_direction = 0
	mover()
func enter():
	player = get_tree().get_nodes_in_group("Player")[0] as CharacterBody2D
	if counter <= 3:
		counter += 1
	else:
		counter = 0
	character_body_2d.velocity.x = 0
	character_body_2d.move_and_slide()
	strike_zone.monitorable=true
func exit():
	hit_zone.position = strike_zone.position
	strike.position = hit_zone.position
	strike_zone.monitorable = false
	
func animation_handler():
	if counter ==1:
		animated_sprite_2d.play("attack_1")
	elif counter == 2:
		animated_sprite_2d.play("attack_2")
	elif counter == 3:
		animated_sprite_2d.play("attack_3")
		counter = 1
func mover():
	strike.move_local_x(2*strike_direction)
