extends TextureProgress

func set_health(n:float):
	value = clamp(n, 0, 1)
