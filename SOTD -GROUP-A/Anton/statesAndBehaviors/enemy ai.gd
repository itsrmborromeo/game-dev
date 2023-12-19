extends CharacterBody2D
@export var node_finite_state_machine :NodeFiniteStateMachine
var player_in_range = false
var has_sight = true
@export var timer : Timer
@onready var player = get_parent().get_node("Jinbei")
var can_attack = true
@export var summon_cd : Timer
func _on_sight_body_entered(body : Node2D):
	if body.is_in_group("Player"):
		node_finite_state_machine.transition_to("chase")


func _on_sight_body_exited(body : Node2D):
	if body.is_in_group("Player"):
		node_finite_state_machine.transition_to("idle")


func _on_range_body_entered(body : Node2D):
	pass # Replace with function body.


func _on_range_body_exited(body : Node2D):
	pass # Replace with function body.
