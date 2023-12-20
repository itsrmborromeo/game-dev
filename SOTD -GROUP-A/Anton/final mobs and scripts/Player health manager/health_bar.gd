extends Node2D

@export var healthbar = TextureProgressBar
@export var danger_color : Color
@export var caution_color : Color
@export var healthy_color : Color
var max_hp = 100
func _ready():
	HpManager.on_hp_change.connect(updater)

func updater(health):
	if health < max_hp * .2 :
		healthbar.tint_progress = danger_color
	elif health < max_hp * .5:
		healthbar.tint_progress = caution_color
	else:
		healthbar.tint_progress = healthy_color
	healthbar.value =health
