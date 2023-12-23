extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$Panel/score.text = str(KillManager.kills)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_retry_button_pressed():
	LifeManager.increase_life(3)
	KillManager.killrst(0)
	GameManager.start_game()

func _on_main_menu_button_pressed():
	GameManager.main_menu()
	queue_free()
