extends Node2D

var player = load("res://Scenes/Player.tscn")

func _ready():
	Global.tm = $"MainMap"

func respawn():
	add_child(player.instance())
