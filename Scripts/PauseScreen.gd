extends Control


var paused = false

func pause_toggle():
	if paused:
#		MusicPlayer.cutoff(1)
		get_tree().paused = false
		paused = false
		hide()
	else:
#		MusicPlayer.cutoff(0.45)
		$"Continue".grab_focus()
		get_tree().paused = true
		paused = true
		show()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		pause_toggle()

func _on_Continue_pressed():
#	MusicPlayer.cutoff(1)
	pause_toggle()
