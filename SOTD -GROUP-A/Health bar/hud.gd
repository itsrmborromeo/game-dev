extends CanvasLayer
var maxHP = 100
var hp: int
var life = 3
var danger_color = Color(1,0,0)
var caution_color = Color(.788,1,0)
var healthy_color = Color(0,1,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	hp = 100
	life = LifeManager.currentLife
	$OverHealthBar.value = hp
	$Lives.text = str(life)
	$TextureRect2/Kills.text = str(KillManager.kills)
	LifeManager.on_lives_changed.connect(life_updater)
	HealthManager.on_health_change.connect(health_updater)
	KillManager.on_kill_counter.connect(kill_update)
func _process(delta):
	pass
func health_updater(current_hp):
	if hp < maxHP * .2:
		$OverHealthBar.tint_progress = danger_color
	elif hp < maxHP *.5:
		$OverHealthBar.tint_progress = caution_color
	else :
		$OverHealthBar.tint_progress = healthy_color
	$Lives.text = str(life)
	$OverHealthBar.value=hp
func life_updater(layp : int):
	life = layp
	$Lives.text = str(life)
	
func _on_button_pressed():
	GameManager.pause_game()
	
func kill_update(score):
	$TextureRect2/Kills.text= str(score)
