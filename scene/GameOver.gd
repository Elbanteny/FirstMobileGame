extends Popup

func _on_ExitGameButton_pressed():
	get_tree().quit()
	#get_tree().set_auto_accept_quit(false) #for mobile mybe

func _on_RetryButton_pressed():
	get_tree().reload_current_scene()
