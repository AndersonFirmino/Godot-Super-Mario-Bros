extends Node2D

func _ready():
	MUSIC.play(MUSIC.MUSIC_LIST.RUNNING_ABOUT)
	VisualServer.set_default_clear_color(Color("#568cee"))
