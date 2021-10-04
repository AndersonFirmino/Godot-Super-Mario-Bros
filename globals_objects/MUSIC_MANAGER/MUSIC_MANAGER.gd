extends Node


var MUSIC_LIST = {
	"DEAD_MARIO": 'dead_mario',
	"UNDERGROUND": 'undergorund',
	"RUNNING_ABOUT": 'running about'
}

##
# Sistema para tocar a trilha sonora do jogo
##
onready var music_list = {
	'dead_mario': $dead_mario,
	'underground': $underground,
	'running about': $running_about

}

##
# Recebe uma das trilhas sonoras como parametro e troca para ela adequadamente.
##
func play(music):
	for cur_music in music_list:
		if cur_music == music:
			music_list[music].play()
		else:
			music_list[cur_music].stop()
