extends CharacterBody2D
@export var state_machine:PlayerNodeFiniteStateMachine
@export var sword: Area2D
var can_double_jump = true
var can_transition =  true
var attack = false
var walk = false
var grounded = true
var jump = false
var animation_done = true
var alive = true
var attacking = false
var need_to_clear = false
func _ready():
	HealthManager.set_health(100)
	HealthManager.on_health_change.connect(updater)
func _process(delta):
	if Input.is_action_just_pressed("debug mode"):
		ProgressManager.progress(1)
	if is_on_floor():
		grounded = true
		can_double_jump = true
	else:
		grounded = false
	if Input.is_action_pressed("left")|| Input.is_action_pressed("right"):
		walk = true
	else:
		walk = false
	if Input.is_action_just_pressed("attackz"):
		attack = true
	elif animation_done:
		attack= false
	if Input.is_action_just_pressed("jump"):
		jump = true
	else:
		jump = false
	transitioner()
func transitioner():
	if alive:
		if grounded:
			if !attacking:
				_on_animated_sprite_2d_animation_finished()
				if can_transition:
					if jump:
						can_transition = false
						jump = false
						$AnimatedSprite2D.play("charge_jump")
						if $AnimatedSprite2D.animation_finished:
							state_machine.transition_to("jump")
					elif walk:
						state_machine.transition_to("walk") and animation_done.play("idle")
					elif attack:
						can_transition = false
						attacking= true
						state_machine.transition_to("attack")
					else:
						state_machine.transition_to("idle")
				else:
					if grounded and jump:
						can_transition = true
			else:
				pass
		elif jump and can_double_jump:
			can_double_jump = false
			$AnimatedSprite2D.play("charge_jump")
			if $AnimatedSprite2D.animation_finished:
				state_machine.transition_to("double_jump")
	else:
		state_machine.transition_to("dead")
		need_to_clear = true
func _on_animated_sprite_2d_animation_finished():
	attacking = false
	can_transition = true
	if need_to_clear:
		LifeManager.decrease_Life(1)
		get_tree().reload_current_scene()

func updater(health):
	if health == 0:
		alive = false
	else:
		$Regen.start(5)
func _on_hurtbox_area_entered(area):
	if area.is_in_group("Enemy"):
		HealthManager.took_damage(area.damage_amount)
		$Regen.start(5)
		
func _on_regen_timeout():
	HealthManager.regain_hp(10)


