"""
Script para gerenciar ações de debug
"""

extends Node


func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS

func _input(event):
	if Input.is_key_pressed(KEY_R):
		get_tree().reload_current_scene()
		get_tree().paused = false

