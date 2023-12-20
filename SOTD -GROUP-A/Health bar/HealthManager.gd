extends Node
var maxHP : int
var currentHP : int
signal on_health_change
# Called when the node enters the scene tree for the first time.
func _ready():
	currentHP = maxHP
# Called every frame. 'delta' is the elapsed time since the previous frame
func took_damage(dmg):
	currentHP -= dmg
	if currentHP < 0:
		currentHP = 0
	on_health_change.emit(currentHP)
	
func regain_hp(rgn : int):
	currentHP -=rgn
	if currentHP > maxHP:
		currentHP = maxHP
	on_health_change.emit(currentHP)
	
func set_health(mx):
	maxHP=mx
	currentHP=maxHP
	on_health_change.emit(currentHP)
