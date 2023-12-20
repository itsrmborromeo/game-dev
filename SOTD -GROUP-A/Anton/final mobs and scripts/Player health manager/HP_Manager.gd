extends Node
var max_health = 100
var current_health : int
signal on_hp_change
func _ready():
	current_health = max_health

func took_damage(damage_amount : int):
	current_health -= damage_amount
	if current_health <= 0:
		current_health = 0
	on_hp_change.emit(current_health)
func regen(regen_amount : int):
	current_health += regen_amount
	if current_health > max_health:
		current_health = max_health
	on_hp_change.emit(current_health)
