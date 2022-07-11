extends TextureRect

export(String, MULTILINE) var text:String

func _ready():
	$"Label".text = text
