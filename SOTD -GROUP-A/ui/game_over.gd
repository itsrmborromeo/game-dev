extends Control


func _on_yes_pressed():
	LifeManager.increase_life(3)
	KillManager.killrst(0)
	GameManager.start_game()


func _on_no_pressed():
	GameManager.main_menu()
	queue_free()
