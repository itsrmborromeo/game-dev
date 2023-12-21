extends Node
var maxLife : int = 3
var currentLife : int
var game_over = preload("res://ui/game_over.tscn")
signal  on_lives_changed

func _ready():
	currentLife = maxLife
func decrease_Life(Life_lost : int):
	currentLife -= Life_lost
	if currentLife < 0:
		currentLife = 0
	if currentLife == 0:
		ProgressManager.prog_reset(-1)
		GameManager.transition_to_scene(game_over.resource_path)
	on_lives_changed.emit(currentLife)

func increase_life(Life_gain : int):
	currentLife += Life_gain
	if currentLife > maxLife:
		currentLife = maxLife
	on_lives_changed.emit(currentLife)
func reset_health(val):
	maxLife = val
