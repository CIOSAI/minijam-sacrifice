extends CanvasLayer

func _setup(tex:Texture, type:int):
	$"Control/TextureRect".texture = tex
	$"Control/Label".text = type
