extends CharacterBody2D
@export var node_finite_state_machine:NodeFiniteStateMachine
var player_in_range = false
var has_sight = true
var received_damage : int
@onready var player = get_parent().get_node("Jinbei")
var can_attack = true
var attack_range = false
@export var HP :int
var alive = true
var attacking = false
var dead_clear = false
@export var attack_cooldown : Timer
@export var shoot_cooldown : Timer
var can_shoot = true
func _on_sight_body_entered(body : Node2D):
	if body.is_in_group("Player"):
		player_in_range = true
func _on_sight_body_exited(body : Node2D):
	if body.is_in_group("Player"):
		player_in_range = false
func _physics_process(delta):
	if alive:
		if !attacking:
			$Strikezone.monitorable = false
			if player_in_range:
				sightCheck()
				if has_sight:
					if can_shoot:
						node_finite_state_machine.transition_to("shoot")
						shoot_cooldown.start(7)
						attacking = true
						can_shoot = false
					elif attack_range:
						if can_attack:
							node_finite_state_machine.transition_to("attack")
							attacking = true
							attack_cooldown.start()
							can_attack = false
						else:
							node_finite_state_machine.transition_to("idle")
					else:
						node_finite_state_machine.transition_to("chase")
				else:
						node_finite_state_machine.transition_to("idle")
			else:
					node_finite_state_machine.transition_to("idle")
		else:
			_on_skeleton_warrior_animation_finished()
	else:
		if !dead_clear:
			dead_clear = true
		if $"Animated Sprite 2D".animation != "dead":
			node_finite_state_machine.transition_to("dead")
			if $"Animated Sprite 2D".animation_finished:
				$"Statemachine/dead/Clear up".start()

func sightCheck():
	if player_in_range:
		var space_state = get_world_2d().direct_space_state
		var query = PhysicsRayQueryParameters2D.create(global_position, player.position)
		query.exclude = [self]
		var result = space_state.intersect_ray(query)
		if result:
			if result.collider.name == "Jinbei":
				has_sight = true
				#print("Player in sight",has_sight)
			else:
				has_sight = false
				#print("Player in sight",has_sight)
func _on_attack__range_body_entered(body):
	if body.is_in_group("Player"):
		attack_range = true
func _on_attack__range_body_exited(body):
	if body.is_in_group("Player"):
		attack_range = false


func _on_attack_cooldown_timeout():
	can_attack = true
	attacking = false


func _on_skeleton_warrior_animation_finished():
	attacking = false 
	
func _on_clear_up_timeout():
	print ("dead")

func _on_hurtbox_area_entered(area):
	if area.is_in_group("Player"):
		received_damage=(area.damage_amount)
	if HP != 0:
		HP = HP - received_damage
		print(HP)
	else:
		alive = false
func _on_shoot_summon_timeout():
	can_shoot = true
