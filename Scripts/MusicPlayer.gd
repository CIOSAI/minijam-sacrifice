extends AudioStreamPlayer

onready var tw = $"Tween"

var lowpass = AudioServer.get_bus_effect(0, 0)

func _ready():
	lowpass.cutoff_hz = 22_000

func cutoff(x:float):
	tw.stop_all()
	tw.interpolate_property(lowpass, "cutoff_hz", 
	lowpass.cutoff_hz, pow(x, 3)*22_000, 0.3, Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
	tw.start()

func boss():
	stop()
	$"AudioStreamPlayer".play()

func unboss():
	play()
	$"AudioStreamPlayer".stop()
