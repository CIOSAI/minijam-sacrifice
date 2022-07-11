extends Node2D

onready var button_focus = $"ButtonFocus"
onready var button_click = $"ButtonClick"

func play_button_focus(): button_focus.play()
func play_button_click(): button_click.play()

