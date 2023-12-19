extends Control


func _on_yes_pressed():
	GameManager.start_game()


func _on_no_pressed():
	GameManager.main_menu()
	queue_free()
