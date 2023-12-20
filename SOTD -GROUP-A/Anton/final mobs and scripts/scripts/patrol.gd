extends NodeState
@export var character_body_2d :CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D
@export var patrol_points : Node
@export var speed : int = 30
var number_of_points : int
var direction : int
var point_positions : Array[Vector2]
var current_point : Vector2
var current_point_position = 0
func on_process(delta:float):
	pass
func on_physics_process(delta:float):
	animated_sprite_2d.play("walk")
	direction_finder()
	#print(current_point_position)
	if abs(character_body_2d.global_position.x - current_point.x) > .5 :
		character_body_2d.velocity.x = speed * direction
		character_body_2d.move_and_slide()
	else:
		mover()
func enter():
	current_point_position = 0
	if patrol_points != null:
		number_of_points = patrol_points.get_children().size()
		for point in patrol_points.get_children():
			point_positions.append(point.global_position)
		current_point = point_positions[current_point_position]
	else:
		print("No patrol points")
func exit():
	if abs(character_body_2d.global_position.x - point_positions[0].x) > abs (character_body_2d.global_position.x - point_positions[1].x):
		current_point_position = 0
	else:
		current_point_position = 1
func direction_finder():
	if character_body_2d.global_position.x >= current_point.x:
		direction = -1
		animated_sprite_2d.flip_h = true
	elif character_body_2d.global_position.x <= current_point.x:
		direction = 1
		animated_sprite_2d.flip_h = false
	#print("Aaahhyhh")
func mover():
	if current_point_position >= (number_of_points - 1):
		current_point_position = 0
	else:
		current_point_position += 1
	current_point = point_positions[current_point_position]
	#print("Point position")
	#print(current_point_position)
