extends CanvasLayer
var maxHP = 100
var hp: int
var previous_hp : int
var life = 3
var danger_color = Color(1,0,0)
var caution_color = Color(.788,1,0)
var healthy_color = Color(0,1,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	previous_hp = 100
	hp = 100
	life = LifeManager.currentLife
	$UnderHealthBar.value = hp
	$OverHealthBar.value = hp
	$Lives.text = str(life)
	LifeManager.on_lives_changed.connect(life_updater)
	HealthManager.on_health_change.connect(health_updater)
func _process(delta):
	pass
func health_updater(current_hp):
	previous_hp = hp
	hp = current_hp
	if previous_hp > hp:
		$UnderHealthBar.tint_progress=danger_color
	else :
		$UnderHealthBar.tint_progress=healthy_color
		
	if hp < maxHP * .2:
		$OverHealthBar.tint_progress = danger_color
	elif hp < maxHP *.5:
		$OverHealthBar.tint_progress = caution_color
	else :
		$OverHealthBar.tint_progress = healthy_color
	$Lives.text = str(life)
	$OverHealthBar.value=hp
	$UnderHealthBar.value=hp
	var tween = get_tree().create_tween()
	tween.tween_property($UnderHealthBar, "value", hp ,3).set_trans(tween.TRANS_LINEAR)
func life_updater(layp : int):
	life = layp
	$Lives.text = str(life)


func _on_button_pressed():
	GameManager.pause_game()
