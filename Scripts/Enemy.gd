extends Entity
class_name Enemy

func death():
	print(name + " has died")
	queue_free()
