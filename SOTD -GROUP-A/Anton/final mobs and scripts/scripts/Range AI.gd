extends CharacterBody2D
@export var state_machine : NodeFiniteStateMachine
@export var attack_cooldown : Timer
@export var Max_HP : int
@export var portal_spawn =Marker2D
@export var DangerColor : Color
@export var CautionColor : Color
@export var HealthyColor : Color
@onready var player = get_parent().get_node("Jinbei")
@onready var hp = Max_HP
var sc = false
var portal = preload("res://portal.tscn")
var alive = true
var can_attack = true
var attacking = false
var has_sight =false
var enemy_in_range = false
var in_attack_range = false
var need_to_clear = false
var can_shoot = true
func _ready():
	$health.set_max(Max_HP)
	$health.value = Max_HP
func _physics_process(_delta):
	if $AnimatedSprite2D.flip_h == true:
		$AnimatedSprite2D.position.x= -12
	else :
		$AnimatedSprite2D.position.x= 14
	if alive:
		if !attacking:
			_on_animated_sprite_2d_animation_finished()
			$strike.monitorable =false
			if enemy_in_range:
				sightCheck()
				if has_sight:
					if can_shoot: 
						state_machine.transition_to("shoot")
						can_shoot = false
						attacking = false
						$Timer2.start()
					if in_attack_range:
						if can_attack:
							state_machine.transition_to("attack")
							can_attack = false
							attacking =true
							$Timer.start(4)
						else:
							state_machine.transition_to("idle")
					else: #not in attack range
						state_machine.transition_to("chase")
				else:# no sight
					state_machine.transition_to("idle")
			else:# no player available
				state_machine.transition_to("idle")
		else:#can't attack
			pass
	else:#dead
		state_machine.transition_to("dead")
		need_to_clear = true
func sightCheck():
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(global_position, player.position)
	query.exclude = [self]
	var result = space_state.intersect_ray(query)
	if result:
		if result.collider.name == "Jinbei":
			has_sight = true
		else:
			has_sight = false
func _on_timer_timeout():
	can_attack = true

func _on_sight_body_entered(body):
	if body.is_in_group("Player"):
		enemy_in_range = true


func _on_sight_body_exited(body):
	if body.is_in_group("Player"):
		enemy_in_range = false

func _on_attack_range_body_entered(body):
	if body.is_in_group("Player"):
		in_attack_range = true

func _on_attack_range_body_exited(body):
	if body.is_in_group("Player"):
		in_attack_range = false

func _on_animated_sprite_2d_animation_finished():
	attacking = false
	if need_to_clear:
		var portal_instance = portal.instantiate()as Node2D
		portal_instance.global_position = portal_spawn.global_position
		get_parent().add_child(portal_instance)
		queue_free()
		
func _on_timer_2_timeout():
	can_shoot = true
#Attack#


func _on_hurt_box_area_entered(area):
	if area.is_in_group("Player_strike"):
		hp = hp - area.damage_amount
	if hp <= 0:
		alive = false
		if !sc:
			sc =true
			KillManager.add_kill(1)
	hbUpdater()
#health bar
func hbUpdater():
	if hp < Max_HP * .2:
		$health.tint_progress = DangerColor
	elif hp < Max_HP *.5:
		$health.tint_progress = CautionColor
	else :
		$health.tint_progress = HealthyColor
	$health.value = hp



