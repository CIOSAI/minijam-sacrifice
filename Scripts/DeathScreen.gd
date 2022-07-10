extends Control

func array_rand(a:Array):
	return a[randi()%a.size()]

func get_string(type:int)->String:
	var output = ""
	output += [
		"Revenge will be done\neven when I lose my blade\n", 
		"My soul\nwill fight on\nin the form of a wisp\n", 
		"I turn myself\ninto a spirit of assistant\n"
		][type]
	
	output += "Wisp of "
	output += [
		"Healing", 
		"Poison", 
		"Power"
		][type]
	output += "\nwill guide the way"
	return output

func _setup(tex:Texture, type:int):
	$"TextureRect".texture = tex
	$"Label".text = get_string(type)

func _on_Retry_pressed():
	print("this is death")
	get_tree().paused = false
	get_tree().reload_current_scene()
