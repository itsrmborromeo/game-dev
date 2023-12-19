extends CanvasLayer

func _on_play_button_pressed():
	GameManager.start_game()
	queue_free()
	
func _on_exit_button_pressed():
	GameManager.exit_game()
	

func _on_option_button_pressed():
	get_tree().change_scene_to_file("res://ui/option_menu.tscn")
	queue_free()
