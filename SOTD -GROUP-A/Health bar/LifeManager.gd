extends Node
var maxLife : int = 3
var currentLife : int

signal  on_lives_changed

func _ready():
	currentLife = maxLife
func decrease_Life(Life_lost : int):
	currentLife -= Life_lost
	if currentLife < 0:
		currentLife = 0
		
	on_lives_changed.emit(currentLife)

func increase_life(Life_gain : int):
	currentLife += Life_gain
	if currentLife > maxLife:
		currentLife = maxLife
	on_lives_changed.emit(currentLife)
func reset_health(val):
	maxLife = val
