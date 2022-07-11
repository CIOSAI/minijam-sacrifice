extends Button


func _on_SoundButton_focus_entered():
	FX.play_button_focus()


func _on_SoundButton_pressed():
	FX.play_button_click()
