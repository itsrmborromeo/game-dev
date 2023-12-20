extends Control


func _on_yes_pressed():
	LifeManager.reset_health(3)
	GameManager.start_game()


func _on_no_pressed():
	GameManager.main_menu()
	queue_free()
